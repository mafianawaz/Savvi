
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Persistent API session credentials.
///
/// Never logs or exposes token values. Only authenticated API calls ask this
/// store for the current access token.
class TokenStorage {
  TokenStorage(this._prefs);

  static const _accessTokenKey = 'savvi_access_token';
  static const _refreshTokenKey = 'savvi_refresh_token';

  final SharedPreferences _prefs;

  String? get accessToken => _prefs.getString(_accessTokenKey);
  String? get refreshToken => _prefs.getString(_refreshTokenKey);

  bool get hasAccessToken =>
      accessToken != null && accessToken!.trim().isNotEmpty;

  Future<void> save({
    required String accessToken,
    String? refreshToken,
  }) async {
    await _prefs.setString(_accessTokenKey, accessToken.trim());

    if (refreshToken != null && refreshToken.trim().isNotEmpty) {
      await _prefs.setString(_refreshTokenKey, refreshToken.trim());
    }

    debugPrint(
      '[AUTH] API token stored (value intentionally hidden). '
      'refreshToken=${refreshToken != null && refreshToken.trim().isNotEmpty}',
    );
  }

  Future<void> clear() async {
    await _prefs.remove(_accessTokenKey);
    await _prefs.remove(_refreshTokenKey);
    debugPrint('[AUTH] API tokens cleared');
  }
}
