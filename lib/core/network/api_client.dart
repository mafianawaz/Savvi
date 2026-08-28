
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../auth/token_storage.dart';
import '../../shared/patterns/feedback.dart';

class ApiClient {
  ApiClient({
    required String baseUrl,
    required TokenStorage tokenStorage,
    required String Function() localeTagProvider,
    Dio? dio,
  })  : _tokenStorage = tokenStorage,
        _localeTagProvider = localeTagProvider,
        dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: baseUrl,
                connectTimeout: const Duration(seconds: 15),
                sendTimeout: const Duration(seconds: 15),
                receiveTimeout: const Duration(seconds: 25),
                contentType: 'application/json',
                responseType: ResponseType.json,
              ),
            ) {
    this.dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final requiresAuth =
              options.extra['requiresAuth'] as bool? ?? true;

          options.headers['Accept-Language'] = _localeTagProvider();

          if (requiresAuth) {
            final token = _tokenStorage.accessToken;

            if (token != null && token.isNotEmpty) {
              options.headers['Authorization'] = 'Bearer $token';
            }
          } else {
            // Defensive: a public endpoint can never accidentally inherit a
            // bearer header from another caller/interceptor.
            options.headers.remove('Authorization');
          }

          debugPrint(
            '[API] --> ${options.method} ${options.uri} '
            'auth=$requiresAuth',
          );

          handler.next(options);
        },
        onResponse: (response, handler) {
          debugPrint(
            '[API] <-- ${response.statusCode} '
            '${response.requestOptions.method} ${response.requestOptions.uri}',
          );

          if (_shouldShowFeedback(response.requestOptions)) {
            final message = _extractMessage(response.data);
            if (message != null) {
              SavFeedback.globalToast(
                message,
                tone: FeedbackTone.success,
              );
            }
          }

          handler.next(response);
        },
        onError: (error, handler) async {
          final status = error.response?.statusCode;
          debugPrint(
            '[API] XX ${status ?? 'NETWORK'} '
            '${error.requestOptions.method} ${error.requestOptions.uri}',
          );

          // A stale/expired token must not survive the session.
          if (status == 401 &&
              (error.requestOptions.extra['requiresAuth'] as bool? ?? true)) {
            await _tokenStorage.clear();
          }

          if (_shouldShowFeedback(error.requestOptions)) {
            final message = _extractMessage(error.response?.data) ??
                _fallbackErrorMessage(error);

            SavFeedback.globalToast(
              message,
              tone: FeedbackTone.error,
            );
          }

          handler.next(error);
        },
      ),
    );
  }

  final Dio dio;
  final TokenStorage _tokenStorage;
  final String Function() _localeTagProvider;

  bool _shouldShowFeedback(RequestOptions options) {
    return options.extra['showFeedback'] as bool? ?? true;
  }

  String? _extractMessage(dynamic data) {
    if (data is! Map) return null;

    final map = Map<String, dynamic>.from(data);
    final candidates = <dynamic>[
      map['message'],
      map['error'],
      map['detail'],
      if (map['data'] is Map) ...[
        (map['data'] as Map)['message'],
        (map['data'] as Map)['error'],
        (map['data'] as Map)['detail'],
      ],
    ];

    for (final value in candidates) {
      if (value is String && value.trim().isNotEmpty) {
        return value.trim();
      }
      if (value is List && value.isNotEmpty) {
        final text = value
            .map((e) => e.toString().trim())
            .where((e) => e.isNotEmpty)
            .join(', ');
        if (text.isNotEmpty) return text;
      }
    }

    return null;
  }

  String _fallbackErrorMessage(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Request timed out. Please try again.';
      case DioExceptionType.connectionError:
        return 'Unable to connect. Please check your internet connection.';
      case DioExceptionType.badCertificate:
        return 'Secure connection failed. Please try again.';
      case DioExceptionType.cancel:
        return 'Request cancelled.';
      default:
        final status = error.response?.statusCode;
        if (status == 401) return 'Your session has expired. Please sign in again.';
        if (status == 403) return 'You do not have permission to perform this action.';
        if (status == 404) return 'The requested resource was not found.';
        if (status != null && status >= 500) return 'Server error. Please try again later.';
        return 'Something went wrong. Please try again.';
    }
  }
}

/// Kept for compatibility with older callers. Production code should use
/// [TokenStorage] instead.
Future<String?> stubTokenProvider() async => null;
