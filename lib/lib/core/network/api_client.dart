import 'package:dio/dio.dart';

/// Structured Dio client for the Savvi backend (NestJS).
///
/// Responsibilities:
///  - base URL + timeouts
///  - attach the Firebase ID token (Authorization: Bearer …) via [tokenProvider]
///  - attach the active locale (Accept-Language) so the backend can localise
///    server-owned copy (emails, some notification bodies)
///  - normalise transport errors
///
/// The token provider is injected rather than imported so this file has no
/// dependency on Firebase yet; the auth stage wires a real provider that reads
/// the current Firebase ID token. In Stage 1 a stub provider returns null.
class ApiClient {
  ApiClient({
    required String baseUrl,
    required Future<String?> Function() tokenProvider,
    required String Function() localeTagProvider,
    Dio? dio,
  })  : _tokenProvider = tokenProvider,
        _localeTagProvider = localeTagProvider,
        dio = dio ??
            Dio(BaseOptions(
              baseUrl: baseUrl,
              connectTimeout: const Duration(seconds: 15),
              receiveTimeout: const Duration(seconds: 20),
              contentType: 'application/json',
            )) {
    this.dio.interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) async {
              final token = await _tokenProvider();
              if (token != null) {
                options.headers['Authorization'] = 'Bearer $token';
              }
              options.headers['Accept-Language'] = _localeTagProvider();
              handler.next(options);
            },
          ),
        );
  }

  final Dio dio;
  final Future<String?> Function() _tokenProvider;
  final String Function() _localeTagProvider;
}

/// Stage-1 stub token provider. Replaced in the auth stage by one that returns
/// the current Firebase ID token.
Future<String?> stubTokenProvider() async => null;
