import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/user.dart';

class UserStorage {
  UserStorage(this._prefs);

  static const _userKey = 'savvi_user';
  final SharedPreferences _prefs;

  UserModel? get user {
    final raw = _prefs.getString(_userKey);
    if (raw == null || raw.isEmpty) return null;
    try {
      return UserModel.decode(raw);
    } catch (_) {
      return null;
    }
  }

  Future<void> save(UserModel user) async {
    await _prefs.setString(_userKey, user.encode());
  }

  Future<void> clear() async {
    await _prefs.remove(_userKey);
  }
}
