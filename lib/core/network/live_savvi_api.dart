import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../notifications/one_signal_service.dart';

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
    String? oneSignalPlayerId,
  }) async {
    try {
      final response = await client.dio.post<Map<String, dynamic>>(
        '/savi-user-auth/login',
        data: {
          'email': email.trim(),
          'password': password,
          if ((oneSignalPlayerId ?? '').trim().isNotEmpty)
            'oneSignalPlayerId': oneSignalPlayerId!.trim(),
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
  Future<ApiResult<Map<String, dynamic>>> getProfile() async {
    try {
      final response = await client.dio.get<Map<String, dynamic>>(
        '/savi-users/me',
        options: Options(extra: const {'requiresAuth': true}),
      );
      return ApiOk(_data(response.data));
    } on DioException catch (e, stack) { return _dioFailure(e, stack); }
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> updateContact(Map<String, dynamic> body) async {
    try {
      final response = await client.dio.patch<Map<String, dynamic>>(
        '/savi-users/contact', data: body,
        options: Options(extra: const {'requiresAuth': true}),
      );
      return ApiOk(_data(response.data));
    } on DioException catch (e, stack) { return _dioFailure(e, stack); }
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> updateDietary(List<String> dietary) async {
    try {
      final response = await client.dio.patch<Map<String, dynamic>>(
        '/savi-users/dietary', data: {'dietary': dietary},
        options: Options(extra: const {'requiresAuth': true}),
      );
      return ApiOk(_data(response.data));
    } on DioException catch (e, stack) { return _dioFailure(e, stack); }
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> updateAllergens(List<String> allergens) async {
    try {
      final response = await client.dio.patch<Map<String, dynamic>>(
        '/savi-users/allergens', data: {'allergens': allergens},
        options: Options(extra: const {'requiresAuth': true}),
      );
      return ApiOk(_data(response.data));
    } on DioException catch (e, stack) { return _dioFailure(e, stack); }
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> updateHousehold(int householdSize) async {
    try {
      final response = await client.dio.patch<Map<String, dynamic>>(
        '/savi-users/household', data: {'householdSize': householdSize},
        options: Options(extra: const {'requiresAuth': true}),
      );
      return ApiOk(_data(response.data));
    } on DioException catch (e, stack) { return _dioFailure(e, stack); }
  }

  @override
  Future<ApiResult<void>> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final response = await client.dio.patch<Map<String, dynamic>>(
        '/savi-users/password',
        data: {
          'oldPassword': oldPassword,
          'newPassword': newPassword,
        },
        options: Options(extra: const {'requiresAuth': true}),
      );
      return const ApiOk(null);
    } on DioException catch (e, stack) {
      return _dioFailure(e, stack);
    } catch (e, stack) {
      debugPrint('[PASSWORD] CHANGE EXCEPTION: $e');
      debugPrintStack(stackTrace: stack);
      return ApiErr(ApiFailure.unknown(e.toString()));
    }
  }

  Map<String, dynamic> _data(Map<String, dynamic>? body) {
    final raw = body?['data'];
    return raw is Map ? Map<String, dynamic>.from(raw) : <String, dynamic>{};
  }

  // ── Requests / Food support ───────────────────────────────────────────────
  @override
  Future<ApiResult<List<String>>> listRequestCategories() async {
    try {
      final response = await client.dio.get<Map<String, dynamic>>(
        '/savi-support-requests/categories',
        options: Options(extra: const {'requiresAuth': true}),
      );
      final raw = response.data?['data'];
      if (raw is! List) return const ApiOk(<String>[]);
      return ApiOk(raw.map((e) => e.toString()).where((e) => e.isNotEmpty).toList());
    } on DioException catch (e, stack) {
      return _dioFailure(e, stack);
    } catch (e, stack) {
      debugPrint('[REQUEST] CATEGORIES EXCEPTION: $e');
      debugPrintStack(stackTrace: stack);
      return ApiErr(ApiFailure.unknown(e.toString()));
    }
  }

  @override
  Future<ApiResult<List<Map<String, dynamic>>>> listRequests({String? tab}) async {
    try {
      final response = await client.dio.get<Map<String, dynamic>>(
        '/savi-support-requests',
        queryParameters: {if (tab != null && tab.isNotEmpty) 'tab': tab},
        options: Options(extra: const {'requiresAuth': true}),
      );
      final raw = response.data?['data'];
      if (raw is! List) return const ApiOk(<Map<String, dynamic>>[]);

      return ApiOk(
        raw.whereType<Map>().map((item) {
          return Map<String, dynamic>.from(item);
        }).toList(),
      );
    } on DioException catch (e, stack) {
      return _dioFailure(e, stack);
    } catch (e, stack) {
      debugPrint('[REQUEST] LIST EXCEPTION: $e');
      debugPrintStack(stackTrace: stack);
      return ApiErr(ApiFailure.unknown(e.toString()));
    }
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> getRequest(String requestId) async {
    try {
      final response = await client.dio.get<Map<String, dynamic>>(
        '/savi-support-requests/$requestId',
        options: Options(extra: const {'requiresAuth': true}),
      );
      return ApiOk(_data(response.data));
    } on DioException catch (e, stack) {
      return _dioFailure(e, stack);
    } catch (e, stack) {
      debugPrint('[REQUEST] GET EXCEPTION: $e');
      debugPrintStack(stackTrace: stack);
      return ApiErr(ApiFailure.unknown(e.toString()));
    }
  }

  @override
  Future<ApiResult<void>> cancelRequest(String requestId) async {
    try {
      await client.dio.patch<Map<String, dynamic>>(
        '/savi-support-requests/$requestId/cancel',
        options: Options(extra: const {'requiresAuth': true}),
      );
      return const ApiOk(null);
    } on DioException catch (e, stack) {
      return _dioFailure(e, stack);
    } catch (e, stack) {
      debugPrint('[REQUEST] CANCEL EXCEPTION: $e');
      debugPrintStack(stackTrace: stack);
      return ApiErr(ApiFailure.unknown(e.toString()));
    }
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> createRequest(Map<String, dynamic> body) async {
    try {
      final response = await client.dio.post<Map<String, dynamic>>(
        '/savi-support-requests',
        data: body,
        options: Options(extra: const {'requiresAuth': true}),
      );
      return ApiOk(_data(response.data));
    } on DioException catch (e, stack) {
      return _dioFailure(e, stack);
    } catch (e, stack) {
      debugPrint('[REQUEST] CREATE EXCEPTION: $e');
      debugPrintStack(stackTrace: stack);
      return ApiErr(ApiFailure.unknown(e.toString()));
    }
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> editRequest(
      String requestId, Map<String, dynamic> body) async {
    try {
      final response = await client.dio.patch<Map<String, dynamic>>(
        '/savi-support-requests/$requestId',
        data: body,
        options: Options(extra: const {'requiresAuth': true}),
      );
      return ApiOk(_data(response.data));
    } on DioException catch (e, stack) {
      return _dioFailure(e, stack);
    } catch (e, stack) {
      debugPrint('[REQUEST] EDIT EXCEPTION: $e');
      debugPrintStack(stackTrace: stack);
      return ApiErr(ApiFailure.unknown(e.toString()));
    }
  }

  // ── Events / Food Access Alerts ───────────────────────────────────────────
  @override
  Future<ApiResult<List<Map<String, dynamic>>>> listAlerts() async {
    try {
      final response = await client.dio.get<Map<String, dynamic>>(
        '/events',
        options: Options(extra: const {'requiresAuth': true}),
      );
      final raw = response.data?['data'];
      if (raw is! List) return const ApiOk(<Map<String, dynamic>>[]);
      return ApiOk(raw.whereType<Map>().map((item) {
        return _normalizeEvent(Map<String, dynamic>.from(item));
      }).toList());
    } on DioException catch (e, stack) {
      return _dioFailure(e, stack);
    } catch (e, stack) {
      debugPrint('[EVENT] LIST EXCEPTION: $e');
      debugPrintStack(stackTrace: stack);
      return ApiErr(ApiFailure.unknown(e.toString()));
    }
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> rsvpAlert(String alertId, int headcount) async {
    return _joinEvent(alertId, headcount, update: false);
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> updateRsvp(String alertId, int headcount) async {
    return _joinEvent(alertId, headcount, update: true);
  }

  Future<ApiResult<Map<String, dynamic>>> _joinEvent(
    String alertId,
    int headcount, {
    required bool update,
  }) async {
    try {
      final response = update
          ? await client.dio.patch<Map<String, dynamic>>(
              '/events/$alertId/join',
              data: {'peopleCount': headcount},
              options: Options(extra: const {'requiresAuth': true}),
            )
          : await client.dio.post<Map<String, dynamic>>(
              '/events/$alertId/join',
              data: {'peopleCount': headcount},
              options: Options(extra: const {'requiresAuth': true}),
            );
      return ApiOk(_normalizeJoinResponse(response.data, fallbackCount: headcount));
    } on DioException catch (e, stack) {
      return _dioFailure(e, stack);
    } catch (e, stack) {
      return ApiErr(ApiFailure.unknown(e.toString()));
    }
  }

  @override
  Future<ApiResult<void>> cancelRsvp(String alertId) async {
    try {
      await client.dio.patch<Map<String, dynamic>>(
        '/events/$alertId/cancel',
        options: Options(extra: const {'requiresAuth': true}),
      );
      return const ApiOk(null);
    } on DioException catch (e, stack) {
      return _dioFailure(e, stack);
    } catch (e, stack) {
      return ApiErr(ApiFailure.unknown(e.toString()));
    }
  }

  Map<String, dynamic> _normalizeEvent(Map<String, dynamic> event) {
    // The live /events response uses `location` as an object (not
    // `locationSnapshot` or a populated `locationId`).
    final rawLocation = event['location'] ?? event['locationSnapshot'];
    final location = rawLocation is Map
        ? Map<String, dynamic>.from(rawLocation)
        : event['locationId'] is Map
            ? Map<String, dynamic>.from(event['locationId'] as Map)
            : <String, dynamic>{};
    final rawJoin = event['join'];
    final join = rawJoin is Map ? Map<String, dynamic>.from(rawJoin) : null;
    final rawCount = join?['peopleCount'] ??
        join?['headcount'] ??
        event['peopleCount'] ??
        (event['myJoin'] == true ? 1 : 0);
    final count = rawCount is num ? rawCount : num.tryParse('$rawCount');
    final remainingRaw = event['servingsRemaining'] ?? event['servingsAvailable'];
    final remaining = remainingRaw is num ? remainingRaw.toInt() : null;
    final alertTypeLabel = (event['alertType'] ?? '').toString().trim();
    final alertType = alertTypeLabel.toLowerCase();
    final isHot = alertType.contains('hot meal');
    // Keep the full venue and street address for the location row and Maps.
    // Some API versions may omit one or more location fields, so use safe fallbacks.
    final locationName = (location['name'] ?? '').toString().trim();
    final address = (location['address'] ?? '').toString().trim();
    final city = (location['city'] ?? '').toString().trim();
    final where = <String>[
      if (locationName.isNotEmpty) locationName,
      if (address.isNotEmpty) address,
      if (city.isNotEmpty) city,
    ].toSet().join(', ');

    return {
      ...event,
      'id': event['id']?.toString() ?? event['_id']?.toString() ?? '',
      'type': isHot ? 'hot' : 'dist',
      'alertTypeLabel': alertTypeLabel,
      'locationName': locationName,
      'host': locationName.isNotEmpty
          ? locationName
          : (event['nonprofitName']?.toString() ?? ''),
      'windowStart': event['servingStartAt'],
      'windowEnd': event['servingEndAt'],
      'where': where,
      // Null serving limits mean the event has no published capacity limit.
      'left': remaining ?? 999999,
      'rsvp': count?.toInt() ?? 0,
      'maxPeople': (event['maxPeople'] as num?)?.toInt(),
    };
  }

  Map<String, dynamic> _normalizeJoinResponse(Map<String, dynamic>? body, {required int fallbackCount}) {
    final raw = body?['data'];
    final data = raw is Map ? Map<String, dynamic>.from(raw) : <String, dynamic>{};
    final join = data['join'] is Map ? Map<String, dynamic>.from(data['join'] as Map) : data;
    final count = (join['peopleCount'] ?? join['headcount'] ?? join['count']) as num?;
    final remaining = (data['servingsRemaining'] ?? data['left']) as num?;
    return {
      ...data,
      'rsvp': count?.toInt() ?? fallbackCount,
      if (remaining != null) 'left': remaining.toInt(),
    };
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
        '/invites/verify',
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
    debugPrint('[API] DIO TYPE=${e.type} message=${e.message}');
    debugPrint('[API] DIO URI=${e.requestOptions.uri}');
    if (e.error != null) {
      debugPrint('[API] DIO UNDERLYING ERROR=${e.error}');
    }
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
  Future<ApiResult<List<Map<String, dynamic>>>> listNotifications({
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final response = await client.dio.get<dynamic>(
        '/savi-user-notifications',
        queryParameters: {'page': page, 'limit': limit},
        options: Options(extra: const {'requiresAuth': true}),
      );
      final body = response.data;
      dynamic rows = body;
      if (body is Map) {
        rows = body['data'] ?? body['notifications'] ?? body['items'] ?? body['results'];
        if (rows is Map) {
          rows = rows['notifications'] ?? rows['items'] ?? rows['results'] ?? rows['data'];
        }
      }
      if (rows is! List) {
        return ApiErr(ApiFailure.unknown('Notifications response was not a list.'));
      }
      return ApiOk(rows.whereType<Map>()
          .map((row) => Map<String, dynamic>.from(row))
          .toList());
    } on DioException catch (e, stack) {
      return _dioFailure(e, stack);
    }
  }

  @override
  Future<ApiResult<void>> markNotificationRead(String id) async {
    try {
      await client.dio.patch<dynamic>(
        '/savi-user-notifications/${Uri.encodeComponent(id)}/read',
        options: Options(extra: const {'requiresAuth': true}),
      );
      return const ApiOk(null);
    } on DioException catch (e, stack) {
      return _dioFailure(e, stack);
    }
  }

  @override
  Future<ApiResult<void>> markAllNotificationsRead() async {
    try {
      await client.dio.patch<dynamic>(
        '/savi-user-notifications/read-all',
        options: Options(extra: const {'requiresAuth': true}),
      );
      return const ApiOk(null);
    } on DioException catch (e, stack) {
      return _dioFailure(e, stack);
    }
  }

  @override
  Future<ApiResult<void>> deleteNotification(String id) async {
    try {
      await client.dio.delete<dynamic>(
        '/savi-user-notifications/${Uri.encodeComponent(id)}',
        options: Options(extra: const {'requiresAuth': true}),
      );
      return const ApiOk(null);
    } on DioException catch (e, stack) {
      return _dioFailure(e, stack);
    }
  }

  @override
  Future<ApiResult<void>> clearNotifications() async {
    try {
      await client.dio.delete<dynamic>(
        '/savi-user-notifications',
        options: Options(extra: const {'requiresAuth': true}),
      );
      return const ApiOk(null);
    } on DioException catch (e, stack) {
      return _dioFailure(e, stack);
    }
  }

  @override
  Future<ApiResult<void>> updateOneSignalPlayerId(String playerId) async {
    try {
      await client.dio.patch<dynamic>(
        '/savi-users/one-signal-player-id',
        data: {'oneSignalPlayerId': playerId},
        options: Options(extra: const {'requiresAuth': true}),
      );
      return const ApiOk(null);
    } on DioException catch (e, stack) {
      return _dioFailure(e, stack);
    }
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> createProfile(
    Map<String, dynamic> body,
  ) async {
    final payload = Map<String, dynamic>.from(body);
    final playerId = await OneSignalService.instance.waitForPlayerId(attempts: 12);
    if (playerId != null && playerId.isNotEmpty) {
      payload['oneSignalPlayerId'] = playerId;
    }
    return _publicPost('/savi-user-auth/register', payload);
  }

  @override
  Future<ApiResult<void>> sendPasswordReset(String email) {
    return _publicPostVoid(
      '/savi-user-auth/password/reset/request',
      {'email': email.trim()},
    );
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> verifyPasswordResetOtp({
    required String email,
    required int otp,
  }) {
    return _publicPost(
      '/savi-user-auth/password/reset/verify-otp',
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
      '/savi-user-auth/password/reset',
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