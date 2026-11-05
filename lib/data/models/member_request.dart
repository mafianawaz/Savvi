import 'enums.dart';
import 'profile_prefs.dart';
import 'request_status.dart';

/// Typed view of a member food-support request returned by the backend.
///
/// `id` is always the backend Mongo/request id used by detail/cancel APIs.
/// `requestCode` is the member-facing code such as SAV-REQ-26-0005.
class MemberRequest {
  const MemberRequest({
    required this.id,
    required this.method,
    required this.status,
    required this.createdAt,
    required this.categories,
    required this.household,
    this.requestCode,
    this.weightLb,
    this.etaLo,
    this.etaHi,
    this.distanceMi,
    this.diet = const [],
    this.allergens = const [],
    this.notes,
    this.pickupCode,
    this.statusHistory = const {},
    this.pickupWindowStart,
    this.pickupWindowEnd,
    this.pickupLocation,
    this.nonprofitName,
    this.phoneNumber,
    this.deliveryAddress,
    this.canCancel = false,
  });

  /// Backend request id (`_id`). Use this for API paths.
  final String id;

  /// Human-facing request code (`requestCode`).
  final String? requestCode;

  final RequestMethod method;
  final RequestStatus status;
  final DateTime createdAt;
  final List<FoodCategory> categories;
  final String household;
  final double? weightLb;
  final int? etaLo;
  final int? etaHi;
  final double? distanceMi;
  final List<DietaryPref> diet;
  final List<Allergen> allergens;
  final String? notes;
  final String? pickupCode;
  final DateTime? pickupWindowStart;
  final DateTime? pickupWindowEnd;
  final String? pickupLocation;
  final Map<RequestStatus, DateTime> statusHistory;
  final String? nonprofitName;
  final String? phoneNumber;
  final Map<String, dynamic>? deliveryAddress;
  final bool canCancel;

  String get displayCode =>
      requestCode?.trim().isNotEmpty == true ? requestCode!.trim() : id;

  static const _closed = <RequestStatus>{
    RequestStatus.completed,
    RequestStatus.cancelled,
    RequestStatus.declined,
    RequestStatus.missed,
    RequestStatus.unavailable,
  };

  bool get isActive => !_closed.contains(status);
  bool get isInFlight =>
      status == RequestStatus.outForDelivery || status == RequestStatus.nearby;

  MemberRequest copyWith({
    RequestStatus? status,
    bool? canCancel,
  }) => MemberRequest(
        id: id,
        requestCode: requestCode,
        method: method,
        status: status ?? this.status,
        createdAt: createdAt,
        categories: categories,
        household: household,
        weightLb: weightLb,
        etaLo: etaLo,
        etaHi: etaHi,
        distanceMi: distanceMi,
        diet: diet,
        allergens: allergens,
        notes: notes,
        pickupCode: pickupCode,
        statusHistory: statusHistory,
        pickupWindowStart: pickupWindowStart,
        pickupWindowEnd: pickupWindowEnd,
        pickupLocation: pickupLocation,
        nonprofitName: nonprofitName,
        phoneNumber: phoneNumber,
        deliveryAddress: deliveryAddress,
        canCancel: canCancel ?? this.canCancel,
      );

  static MemberRequest fromJson(Map<String, dynamic> j) {
    final rawCategories = j['categories'] ?? j['cats'];
    final rawDiet = j['dietary'] ?? j['diet'];
    final rawAllergens = j['allergens'];
    final rawAddress = j['deliveryAddress'] ?? j['address'];

    final method = RequestMethod.fromApi(
      j['method']?.toString() ?? 'Pickup',
    );
    final status = RequestStatus.fromApi(
      j['status']?.toString() ?? 'Submitted',
    );

    return MemberRequest(
      id: (j['_id'] ?? j['id'] ?? '').toString(),
      requestCode: j['requestCode']?.toString(),
      method: method,
      status: status,
      createdAt: DateTime.tryParse(j['createdAt']?.toString() ?? '') ??
          DateTime.now(),
      categories: _categories(rawCategories),
      household: (j['householdSize'] ?? j['household'] ?? 1).toString(),
      weightLb: (j['weightLb'] as num?)?.toDouble(),
      etaLo: (j['etaLo'] as num?)?.toInt(),
      etaHi: (j['etaHi'] as num?)?.toInt(),
      distanceMi: (j['distanceMi'] as num?)?.toDouble(),
      diet: _diet(rawDiet),
      allergens: _allergens(rawAllergens),
      notes: _nullableString(j['notes']),
      pickupCode: _nullableString(
        j['pickupCode'] ??
            j['pickup_code'] ??
            j['pickUpCode'] ??
            j['pickup_code_value'] ??
            j['code'],
      ),
      nonprofitName: _nonprofitName(j['nonprofitName'], j['nonprofitId']),
      phoneNumber: _nullableString(j['phoneNumber']),
      deliveryAddress: rawAddress is Map
          ? Map<String, dynamic>.from(rawAddress)
          : null,
      canCancel: j['canCancel'] == true,
      statusHistory: _statusHistory(        j['statusHistory'],
          currentStatus: status,
          updatedAt: DateTime.tryParse(j['updatedAt']?.toString() ?? ''),      ),
    );
  }

  MemberRequest withPickupDetails(Map<String, dynamic> response) {
    // APIs may wrap the pickup object in `data` or `pickup`.
    dynamic payload = response['data'] ?? response['pickup'];
    final pk = payload is Map
        ? Map<String, dynamic>.from(payload)
        : response;
    final rawLocation = pk['location'] ?? pk['pickupLocation'] ??
        pk['pickup_location'];
    final location = rawLocation is Map
        ? _nullableString(
            rawLocation['name'] ??
                rawLocation['address'] ??
                rawLocation['locationName'],
          )
        : _nullableString(rawLocation);

    return MemberRequest(
      id: id,
      requestCode: requestCode,
      method: method,
      status: status,
      createdAt: createdAt,
      categories: categories,
      household: household,
      weightLb: weightLb,
      etaLo: etaLo,
      etaHi: etaHi,
      distanceMi: distanceMi,
      diet: diet,
      allergens: allergens,
      notes: notes,
      statusHistory: statusHistory,
      pickupCode: _nullableString(
            pk['pickupCode'] ??
                pk['pickup_code'] ??
                pk['pickUpCode'] ??
                pk['pickup_code_value'] ??
                pk['code'],
          ) ??
          pickupCode,
      pickupWindowStart: DateTime.tryParse(
            (pk['windowStart'] ?? pk['pickupWindowStart'] ??
                        pk['pickup_window_start'])
                    ?.toString() ??
                '',
          ) ??
          pickupWindowStart,
      pickupWindowEnd: DateTime.tryParse(
            (pk['windowEnd'] ?? pk['pickupWindowEnd'] ??
                        pk['pickup_window_end'])
                    ?.toString() ??
                '',
          ) ??
          pickupWindowEnd,
      pickupLocation: location ?? pickupLocation,
      nonprofitName: nonprofitName,
      phoneNumber: phoneNumber,
      deliveryAddress: deliveryAddress,
      canCancel: canCancel,
    );
  }

  static List<FoodCategory> _categories(dynamic raw) {
    if (raw is! List) return const [];
    return [
      for (final value in raw)
        if (value != null)
          if (FoodCategory.tryFromRequestApi(value.toString()) case final c?) c,
    ];
  }

  static List<DietaryPref> _diet(dynamic raw) {
    if (raw is! List) return const [];
    return [
      for (final value in raw)
        if (value != null)
          if (_dietary(value.toString()) case final d?) d,
    ];
  }

  static DietaryPref? _dietary(String value) {
    final v = value.trim().toLowerCase();
    for (final d in DietaryPref.values) {
      if (d.api.toLowerCase() == v || d.profileApi.toLowerCase() == v) {
        return d;
      }
    }
    return null;
  }

  static List<Allergen> _allergens(dynamic raw) {
    if (raw is! List) return const [];
    return [
      for (final value in raw)
        if (value != null)
          if (_allergen(value.toString()) case final a?) a,
    ];
  }

  static Allergen? _allergen(String value) {
    final v = value.trim().toLowerCase();
    for (final a in Allergen.values) {
      if (a.api.toLowerCase() == v || a.profileApi.toLowerCase() == v) {
        return a;
      }
    }
    return null;
  }

  static Map<RequestStatus, DateTime> _statusHistory(
    dynamic raw, {
    RequestStatus? currentStatus,
    DateTime? updatedAt,
  }) {
    final result = <RequestStatus, DateTime>{};
    if (raw is Map) {
      for (final entry in raw.entries) {
        final status = RequestStatus.tryFromApi(entry.key.toString());
        final date = DateTime.tryParse(entry.value?.toString() ?? '');
        if (status != null && date != null) result[status] = date;
      }
    }
    // Some responses only expose updatedAt, not statusHistory. Use it for
    // the current status so the timeline still displays a full timestamp.
    if (currentStatus != null && updatedAt != null) {
      result.putIfAbsent(currentStatus, () => updatedAt);
    }
    return result;
  }

  static String? _nonprofitName(dynamic value, dynamic nonprofit) {
    final direct = _nullableString(value);
    if (direct != null) return direct;
    if (nonprofit is Map) {
      return _nullableString(nonprofit['name']);
    }
    return null;
  }

  static String? _nullableString(dynamic value) {
    final text = value?.toString().trim();
    return text == null || text.isEmpty ? null : text;
  }
}

/// Food Access Alert (hot meal or distribution) a member can RSVP to.
enum AlertType {
  hot('hot'),
  distribution('dist');

  const AlertType(this.api);
  final String api;

  static AlertType fromApi(String? v) =>
      v == 'hot' ? AlertType.hot : AlertType.distribution;
}

class FoodAlert {
  const FoodAlert({
    required this.id,
    required this.type,
    required this.title,
    required this.host,
    required this.windowStart,
    required this.windowEnd,
    required this.where,
    required this.left,
    required this.rsvp,
    this.maxPeople,
    this.description = '',
    this.alertType = '',
    this.allergenInfo,
    this.requirements,
    this.locationName = '',
    this.myJoin = false,
  });
  static String? _nullableString(dynamic value) {
    final text = value?.toString().trim();
    return text == null || text.isEmpty ? null : text;
  }


  final String id;
  final AlertType type;
  final String title;
  final String host;
  final DateTime windowStart;
  final DateTime? windowEnd;
  final String where;
  final int left;
  final int rsvp;
  final int? maxPeople;
  final String description;
  final String alertType;
  final String? allergenInfo;
  final String? requirements;
  final String locationName;
  final bool myJoin;

  FoodAlert copyWith({int? rsvp, int? left}) => FoodAlert(
        id: id,
        type: type,
        title: title,
        host: host,
        windowStart: windowStart,
        windowEnd: windowEnd,
        where: where,
        left: left ?? this.left,
        rsvp: rsvp ?? this.rsvp,
        maxPeople: maxPeople ?? this.maxPeople,
        description: description,
        alertType: alertType,
        allergenInfo: allergenInfo,
        requirements: requirements,
        locationName: locationName,
        myJoin: myJoin,
      );

  static FoodAlert fromJson(Map<String, dynamic> j) => FoodAlert(
        id: j['id']?.toString() ?? j['_id']?.toString() ?? '',
        type: AlertType.fromApi(j['type']?.toString()),
        title: j['title']?.toString() ?? '',
        host: j['host']?.toString() ?? '',
        windowStart:
            DateTime.tryParse(j['windowStart']?.toString() ?? '') ??
                DateTime.now(),
        windowEnd: DateTime.tryParse(j['windowEnd']?.toString() ?? ''),
        where: j['where']?.toString() ?? '',
        left: (j['left'] as num?)?.toInt() ??
            (j['servingsRemaining'] as num?)?.toInt() ?? 0,
        rsvp: (j['rsvp'] as num?)?.toInt() ?? 0,
        maxPeople: (j['maxPeople'] as num?)?.toInt(),
        description: j['description']?.toString() ?? '',
        alertType: (j['alertTypeLabel'] ?? j['alertType'] ?? '').toString(),
        allergenInfo: _nullableString(j['allergenInfo']),
        requirements: _nullableString(j['requirements']),
        locationName: (j['locationName'] ?? (j['location'] is Map ? (j['location'] as Map)['name'] : null) ?? j['host'] ?? '').toString(),
        myJoin: j['myJoin'] == true,
      );
}
