import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../data/mock/mock_savvi_api.dart';
import 'api_client.dart';
import 'api_result.dart';

/// Real backend implementation for the access/onboarding APIs.
///
/// Other SavviApi methods are inherited from MockSavviApi until their backend
/// contracts are supplied. Access verification is fully live.
class LiveSavviApi extends MockSavviApi {
  LiveSavviApi(this.client);

  final ApiClient client;

  @override
  Future<ApiResult<Map<String, dynamic>>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await client.dio.post<Map<String, dynamic>>(
        '/userAuth/login',
        data: {
          'email': email.trim(),
          'password': password,
        },
        options: Options(
          extra: const {
            'requiresAuth': false,
            // Login feedback is useful globally, so the API interceptor
            // displays the backend message once for both success and failure.
            'showFeedback': true,
          },
          headers: const {'ngrok-skip-browser-warning': 'true'},
        ),
      );

      final body = response.data ?? <String, dynamic>{};
      final rawData = body['data'];
      final data = rawData is Map
          ? Map<String, dynamic>.from(rawData)
          : <String, dynamic>{};
      final token = data['token']?.toString();
      final rawUser = data['user'];

      if (token == null || token.isEmpty || rawUser is! Map) {
        return ApiErr(
          ApiFailure.unknown('Login response did not contain token/user data.'),
        );
      }

      // Return the raw backend-shaped data. AuthController owns persistence
      // and converts the user payload into the typed UserModel.
      return ApiOk({
        'token': token,
        'user': Map<String, dynamic>.from(rawUser),
      });
    } on DioException catch (e, stack) {
      return _dioFailure(e, stack);
    } catch (e, stack) {
      debugPrint('[AUTH] LOGIN EXCEPTION: $e');
      debugPrintStack(stackTrace: stack);
      return ApiErr(ApiFailure.unknown(e.toString()));
    }
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> verifyAccessLink(
      String tokenOrCode,
      ) async {
    return _verify(tokenOrCode, 'link');
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> verifyQr({
    required String token,
    required String purpose,
  }) async {
    return _verify(token, 'qr');
  }

  Future<ApiResult<Map<String, dynamic>>> _verify(
      String value,
      String source,
      ) async {
    final code = _extractCode(value);

    debugPrint('================ ACCESS VERIFY ================');
    debugPrint('Original value: $value');
    debugPrint('Extracted code: $code');
    debugPrint('Source: $source');

    if (code.isEmpty) {
      return ApiErr(
        ApiFailure.unknown('Empty invite code'),
      );
    }

    try {
      final response = await client.dio.post<Map<String, dynamic>>(
        '/invite/verify',
        data: {
          'code': code,
          'source': source,
        },
        options: Options(
          extra: const {'requiresAuth': false},
          headers: const {
            'ngrok-skip-browser-warning': 'true',
          },
        ),
      );

      debugPrint('STATUS: ${response.statusCode}');
      debugPrint('RESPONSE: ${response.data}');

      final body = response.data ?? <String, dynamic>{};

      final rawData = body['data'];

      final data = rawData is Map
          ? Map<String, dynamic>.from(rawData)
          : <String, dynamic>{};

      debugPrint('DATA: $data');

      /*
       * Backend response:
       *
       * {
       *   "status": "200",
       *   "message": "Access verified...",
       *   "data": {
       *      "valid": true,
       *      "code": "southwes-523890",
       *      "inviteType": "individual_link",
       *      "locationName": "Southwest Community Pantry",
       *      "locationId": "...",
       *      ...
       *   }
       * }
       */

      final valid = data['valid'] == true;

      if (valid) {
        // Your model expects a state.
        data['state'] = 'ok';

        // Keep compatibility with older model/API naming.
        if (data['nonprofit'] == null &&
            data['locationName'] != null) {
          data['nonprofit'] = data['locationName'];
        }

        debugPrint('ACCESS VERIFIED');
        debugPrint('CODE: ${data['code']}');
        debugPrint('LOCATION: ${data['locationName']}');

        return ApiOk(data);
      }

      /*
       * Backend returned HTTP 200 but valid=false.
       * Preserve the backend message instead of hiding it.
       */
      final message =
          data['message']?.toString() ??
              body['message']?.toString() ??
              'Access link or code is invalid';

      data['state'] = _mapBackendState(data);

      data['message'] = message;

      debugPrint('ACCESS INVALID: $message');

      return ApiOk(data);
    } on DioException catch (e) {
      final status = e.response?.statusCode;
      final responseData = e.response?.data;

      debugPrint('DIO ERROR');
      debugPrint('STATUS: $status');
      debugPrint('DATA: $responseData');

      String? detail;

      if (responseData is Map) {
        final responseMap = Map<String, dynamic>.from(responseData);

        final rawData = responseMap['data'];

        if (rawData is Map) {
          detail =
              rawData['message']?.toString() ??
                  rawData['error']?.toString();
        }

        detail ??= responseMap['message']?.toString();
        detail ??= responseMap['error']?.toString();
        detail ??= responseMap['detail']?.toString();
      } else {
        detail = responseData?.toString();
      }

      if (status == 401) {
        return ApiErr(ApiFailure.unauthorized());
      }

      if (status != null && status >= 400) {
        return ApiErr(
          ApiFailure.server(status, detail),
        );
      }

      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        return ApiErr(ApiFailure.timeout());
      }

      return ApiErr(ApiFailure.network());
    } catch (e, stack) {
      debugPrint('VERIFY EXCEPTION: $e');
      debugPrintStack(stackTrace: stack);

      return ApiErr(
        ApiFailure.unknown(e.toString()),
      );
    }
  }


  Future<ApiResult<Map<String, dynamic>>> _publicPost(
    String path,
    Map<String, dynamic> body,
  ) async {
    try {
      final response = await client.dio.post<Map<String, dynamic>>(
        path,
        data: body,
        options: Options(
          extra: const {'requiresAuth': false},
          headers: const {'ngrok-skip-browser-warning': 'true'},
        ),
      );

      final envelope = response.data ?? <String, dynamic>{};
      final rawData = envelope['data'];

      final data = rawData is Map
          ? Map<String, dynamic>.from(rawData)
          : envelope;

      debugPrint('[API] ${response.requestOptions.method} ${response.requestOptions.path}');
      debugPrint('[API] status=${response.statusCode}');
      debugPrint('[API] response=${response.data}');

      return ApiOk(data);
    } on DioException catch (e, stack) {
      return _dioFailure(e, stack);
    } catch (e, stack) {
      debugPrint('[API] EXCEPTION: $e');
      debugPrintStack(stackTrace: stack);
      return ApiErr(ApiFailure.unknown(e.toString()));
    }
  }

  Future<ApiResult<void>> _publicPostVoid(
    String path,
    Map<String, dynamic> body,
  ) async {
    final result = await _publicPost(path, body);
    return result.when(
      ok: (_) => const ApiOk(null),
      err: (failure) => ApiErr(failure),
    );
  }

  ApiErr<T> _dioFailure<T>(DioException e, StackTrace stack) {
    final status = e.response?.statusCode;
    final responseData = e.response?.data;

    debugPrint('[API] DIO ERROR status=$status data=$responseData');
    debugPrintStack(stackTrace: stack);

    String? detail;

    if (responseData is Map) {
      final map = Map<String, dynamic>.from(responseData);
      final nested = map['data'];

      if (nested is Map) {
        detail = nested['message']?.toString() ?? nested['error']?.toString();
      }

      detail ??= map['message']?.toString();
      detail ??= map['error']?.toString();
      detail ??= map['detail']?.toString();
    } else {
      detail = responseData?.toString();
    }

    if (status == 401) {
      return ApiErr(ApiFailure.unauthorized());
    }

    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      return ApiErr(ApiFailure.timeout());
    }

    if (status != null && status >= 400) {
      return ApiErr(ApiFailure.server(status, detail));
    }

    return ApiErr(ApiFailure.network());
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> createProfile(
    Map<String, dynamic> body,
  ) {
    return _publicPost('/userAuth/signup', body);
  }

  @override
  Future<ApiResult<void>> sendPasswordReset(String email) {
    return _publicPostVoid(
      '/userAuth/password/reset/request',
      {'email': email.trim()},
    );
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> verifyPasswordResetOtp({
    required String email,
    required int otp,
  }) {
    return _publicPost(
      '/userAuth/password/reset/verify-otp',
      {
        'email': email.trim(),
        'otp': otp,
      },
    );
  }

  @override
  Future<ApiResult<void>> resetPassword({
    required String email,
    required String password,
  }) {
    return _publicPostVoid(
      '/userAuth/password/reset',
      {
        'email': email.trim(),
        'password': password,
      },
    );
  }

  String _mapBackendState(Map<String, dynamic> data) {
    final state = data['state']?.toString().toLowerCase();

    if (state == 'expired') {
      return 'expired';
    }

    if (state == 'used') {
      return 'used';
    }

    if (state == 'onsite') {
      return 'onsite';
    }

    return 'invalid';
  }

  /// Supports:
  ///
  /// southwes-523890
  ///
  /// https://example.com/invite/southwes-523890
  ///
  /// https://example.com/invite?code=southwes-523890
  ///
  /// https://example.com/invite?inviteCode=southwes-523890
  ///
  /// QR payloads containing a JSON object with a code/token.
  String _extractCode(String input) {
    final value = input.trim();

    if (value.isEmpty) {
      return '';
    }

    // ----------------------------------------------------------
    // 1. Try JSON QR payload
    // ----------------------------------------------------------

    try {
      final decoded = jsonDecode(value);

      if (decoded is Map) {
        final map = Map<String, dynamic>.from(decoded);

        for (final key in const [
          'code',
          'inviteCode',
          'token',
          'accessCode',
        ]) {
          final candidate = map[key]?.toString().trim();

          if (candidate != null && candidate.isNotEmpty) {
            return candidate;
          }
        }
      }
    } catch (_) {
      // Not JSON, continue.
    }

    // ----------------------------------------------------------
    // 2. Try URL
    // ----------------------------------------------------------

    final uri = Uri.tryParse(value);

    if (uri != null && uri.hasScheme && uri.host.isNotEmpty) {
      for (final key in const [
        'code',
        'inviteCode',
        'invite',
        'token',
        'accessCode',
      ]) {
        final queryValue = uri.queryParameters[key];

        if (queryValue != null &&
            queryValue.trim().isNotEmpty) {
          return queryValue.trim();
        }
      }

      final segments = uri.pathSegments
          .where((segment) => segment.trim().isNotEmpty)
          .toList();

      if (segments.isNotEmpty) {
        return segments.last.trim();
      }
    }

    // ----------------------------------------------------------
    // 3. Raw access code
    // ----------------------------------------------------------

    return value;
  }
}