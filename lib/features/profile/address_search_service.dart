import 'dart:async';
import 'package:dio/dio.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AddressSuggestion {
  const AddressSuggestion({required this.placeId, required this.description});
  final String placeId;
  final String description;
}

class ResolvedAddress {
  const ResolvedAddress({
    required this.street,
    required this.city,
    required this.state,
    required this.zip,
    required this.coordinates,
  });
  final String street;
  final String city;
  final String state;
  final String zip;
  final List<double> coordinates;
}

/// Paste your Google key here for local testing, or leave it empty and pass it
/// with --dart-define=GOOGLE_PLACES_API_KEY=...
const String googlePlacesAPIKey = 'AIzaSyD3Z1lEd8PkfCPrgeZYXuv4rH0AocMtVuw';

/// Google Places REST adapter. Keep the key outside source control where
/// possible. Restrict the key by app, package/bundle id and Places API usage
/// in Google Cloud.
class AddressSearchService {
  AddressSearchService({Dio? dio}) : _dio = dio ?? Dio();
  final Dio _dio;

  // NOTE: String.fromEnvironment() takes the NAME of a --dart-define variable,
  // not the key itself. The old code passed the key (an empty string) as the
  // name, so apiKey was always '' and autocomplete silently returned nothing.
  static const String _definedKey =
  String.fromEnvironment('GOOGLE_PLACES_API_KEY');
  static String get apiKey =>
      googlePlacesAPIKey.trim().isNotEmpty ? googlePlacesAPIKey.trim() : _definedKey;

  static const _placesBase = 'https://places.googleapis.com/v1';

  /// SHA-1 of the signing certificate, no colons, e.g.
  /// --dart-define=ANDROID_CERT_SHA1=AABBCC...  (debug and release keystores
  /// have different SHA-1s; both must be added to the key's restrictions).
  static const String _androidCertSha1 = String.fromEnvironment(
    'ANDROID_CERT_SHA1',
    defaultValue: '05:03:D3:0C:41:ED:12:EF:0B:00:CA:A8:7B:27:E3:A1:9D:E5:43:0F',
  );

  static Map<String, String>? _appHeaders;

  /// A key restricted to "Android apps" / "iOS apps" in Google Cloud only works
  /// when the REST request identifies the app. The Maps/Places SDKs add these
  /// headers automatically; a plain Dio call does not, hence the 403
  /// API_KEY_ANDROID_APP_BLOCKED.
  static Future<Map<String, String>> _identityHeaders() async {
    if (_appHeaders != null) return _appHeaders!;
    final headers = <String, String>{};
    try {
      final info = await PackageInfo.fromPlatform();
      if (!kIsWeb && Platform.isAndroid) {
        headers['X-Android-Package'] = info.packageName;
        if (_androidCertSha1.isNotEmpty) {
          headers['X-Android-Cert'] = _androidCertSha1.replaceAll(':', '').toUpperCase();
        }
      } else if (!kIsWeb && Platform.isIOS) {
        headers['X-Ios-Bundle-Identifier'] = info.packageName;
      }
    } catch (e) {
      debugPrint('[PLACES] could not read app identity: $e');
    }
    return _appHeaders = headers;
  }

  /// Uses the Places API (New). Enable "Places API (New)" for the key's project
  /// in Google Cloud Console (APIs & Services > Library) and make sure billing
  /// is on. The legacy "Places API" is NOT used any more.
  void _logDioError(String tag, Object e) {
    if (e is DioException) {
      debugPrint('[PLACES] $tag failed status=${e.response?.statusCode} '
          'body=${e.response?.data}');
    } else {
      debugPrint('[PLACES] $tag failed: $e');
    }
  }

  Future<List<AddressSuggestion>> autocomplete(String input) async {
    if (apiKey.isEmpty || input.trim().length < 3) return const [];
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '$_placesBase/places:autocomplete',
        data: {
          'input': input.trim(),
          'includedRegionCodes': ['us'],
        },
        options: Options(headers: {
          'X-Goog-Api-Key': apiKey,
          'Content-Type': 'application/json',
          ...await _identityHeaders(),
        }),
      );
      final suggestions = response.data?['suggestions'];
      if (suggestions is! List) return const [];
      return suggestions
          .whereType<Map>()
          .map((s) => s['placePrediction'])
          .whereType<Map>()
          .map((p) {
        final text = p['text'];
        return AddressSuggestion(
          placeId: p['placeId']?.toString() ?? '',
          description: text is Map ? text['text']?.toString() ?? '' : '',
        );
      })
          .where((x) => x.placeId.isNotEmpty && x.description.isNotEmpty)
          .toList();
    } catch (e) {
      _logDioError('autocomplete', e);
      return const [];
    }
  }

  Future<ResolvedAddress?> resolve(String placeId) async {
    if (apiKey.isEmpty || placeId.isEmpty) return null;
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '$_placesBase/places/$placeId',
        options: Options(headers: {
          'X-Goog-Api-Key': apiKey,
          'X-Goog-FieldMask': 'addressComponents,location',
          ...await _identityHeaders(),
        }),
      );
      final result = response.data;
      if (result == null) return null;
      final components = result['addressComponents'];
      String component(String type, {bool short = false}) {
        if (components is! List) return '';
        for (final c in components.whereType<Map>()) {
          final types = c['types'];
          if (types is List && types.map((e) => e.toString()).contains(type)) {
            return (short ? c['shortText'] : c['longText'])?.toString() ?? '';
          }
        }
        return '';
      }

      final location = result['location'];
      final lat = location is Map ? double.tryParse('${location['latitude']}') : null;
      final lng = location is Map ? double.tryParse('${location['longitude']}') : null;
      return ResolvedAddress(
        street: [component('street_number'), component('route')]
            .where((e) => e.isNotEmpty).join(' '),
        city: component('locality').isNotEmpty
            ? component('locality')
            : component('postal_town'),
        state: component('administrative_area_level_1'),
        zip: component('postal_code'),
        coordinates: lat != null && lng != null ? [lng, lat] : const [],
      );
    } catch (e) {
      _logDioError('details', e);
      return null;
    }
  }

  /// Geocodes a manually typed address into [lng, lat] (GeoJSON order, same as
  /// [resolve]). Uses Google when a key is configured, otherwise (or if Google
  /// finds nothing) falls back to OpenStreetMap Nominatim, which needs no key.
  Future<List<double>> geocode(String address) async {
    final q = address.trim();
    if (q.isEmpty) return const [];
    if (apiKey.isNotEmpty) {
      final g = await _googleGeocode(q);
      if (g.isNotEmpty) return g;
    }
    return _nominatimGeocode(q);
  }

  Future<List<double>> _googleGeocode(String q) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        'https://maps.googleapis.com/maps/api/geocode/json',
        queryParameters: {'address': q, 'components': 'country:US', 'key': apiKey},
        options: Options(headers: await _identityHeaders()),
      );
      final results = response.data?['results'];
      if (results is! List || results.isEmpty) return const [];
      final geometry = (results.first as Map)['geometry'];
      final location = geometry is Map ? geometry['location'] : null;
      final lat = location is Map ? double.tryParse('${location['lat']}') : null;
      final lng = location is Map ? double.tryParse('${location['lng']}') : null;
      return lat != null && lng != null ? [lng, lat] : const [];
    } catch (_) {
      return const [];
    }
  }

  Future<List<double>> _nominatimGeocode(String q) async {
    try {
      final response = await _dio.get<List<dynamic>>(
        'https://nominatim.openstreetmap.org/search',
        queryParameters: {
          'q': q,
          'format': 'json',
          'limit': 1,
          'countrycodes': 'us',
        },
        options: Options(headers: {'User-Agent': 'savvi-app/1.0'}),
      );
      final data = response.data;
      if (data == null || data.isEmpty) return const [];
      final first = data.first as Map;
      final lat = double.tryParse('${first['lat']}');
      final lng = double.tryParse('${first['lon']}');
      return lat != null && lng != null ? [lng, lat] : const [];
    } catch (_) {
      return const [];
    }
  }
}