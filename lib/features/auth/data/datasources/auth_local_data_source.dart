import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import 'dart:convert';

abstract class AuthLocalDataSource {
  Future<UserModel> login(String email, String password);
  Future<void> logout();
  Future<UserModel?> getCurrentUser();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  static const String USER_KEY = 'CACHED_USER';

  @override
  Future<UserModel> login(String email, String password) async {
    // Simple mock authentication - in real app, this would call an API
    if (email.isNotEmpty && password.length >= 6) {
      final user = UserModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        email: email,
        name: email.split('@')[0].replaceAll(RegExp(r'[^a-zA-Z\s]'), ''),
      );

      await sharedPreferences.setString(USER_KEY, json.encode(user.toJson()));
      return user;
    }
    throw Exception('Invalid credentials');
  }

  @override
  Future<void> logout() async {
    await sharedPreferences.remove(USER_KEY);
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    final userString = sharedPreferences.getString(USER_KEY);
    if (userString != null) {
      return UserModel.fromJson(json.decode(userString));
    }
    return null;
  }
}
