import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureSessionManager {
  static final SecureSessionManager _instance = SecureSessionManager._internal();
  static const _storage = FlutterSecureStorage();

  static const _userTokenKey = 'user_token';
  static const _userIdKey = 'user_id';

  factory SecureSessionManager() {
    return _instance;
  }

  SecureSessionManager._internal();

  Future<void> saveAuthToken(String token) async {
    await _storage.write(key: _userTokenKey, value: token);
  }

  Future<String?> fetchAuthToken() async {
    return await _storage.read(key: _userTokenKey);
  }

  Future<void> saveUserId(int userId) async {
    await _storage.write(key: _userIdKey, value: userId.toString());
  }

  Future<int?> fetchUserId() async {
    final id = await _storage.read(key: _userIdKey);
    return id == null ? null : int.tryParse(id);
  }

  Future<void> clearSession() async {
    await _storage.deleteAll();
  }
}
