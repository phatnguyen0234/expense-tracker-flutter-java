import 'package:dio/dio.dart';
import '../../core/api/dio_client.dart';
import '../../core/storage/secure_storage.dart';

class AuthService {
  static Future<bool> login(String email, String password) async {
    try {
      final response = await DioClient.dio.post(
        "/auth/login",
        data: {
          "email": email,
          "password": password,
        },
      );

      final token = response.data["token"];
      await SecureStorage.saveToken(token);

      return true;
    } catch (e) {
      print("Login error: $e");
      return false;
    }
  }

  static Future<void> logout() async {
    await SecureStorage.deleteToken();
  }
}