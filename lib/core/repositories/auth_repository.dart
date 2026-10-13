import 'package:dio/dio.dart';
import '../network/api_client.dart';

class AuthRepository {
  final ApiClient _client;

  AuthRepository(this._client);

  Future<Map<String, dynamic>> login(String email, String password, {String? deviceName}) async {
    try {
      final response = await _client.dio.post(
        'auth/login',
        data: {
          'email': email,
          'password': password,
          'device_name': deviceName ?? 'Flutter App',
        },
      );

      if (response.data['success'] == true) {
        final data = response.data['data'];
        await _client.setTokens(
          data['access_token'],
          data['refresh_token'],
        );
        return data;
      } else {
        throw Exception(response.data['message'] ?? 'Login failed');
      }
    } on DioException catch (e) {
      final message = e.response?.data['message'] ?? e.message ?? 'Network error';
      throw Exception(message);
    }
  }

  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    String? phone,
  }) async {
    try {
      final response = await _client.dio.post(
        'auth/register',
        data: {
          'name': name,
          'email': email,
          'password': password,
          if (phone != null) 'phone': phone,
        },
      );

      if (response.data['success'] == true) {
        return response.data['data'];
      } else {
        throw Exception(response.data['message'] ?? 'Registration failed');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message ?? 'Network error');
    }
  }

  Future<Map<String, dynamic>> me() async {
    try {
      final response = await _client.dio.get('auth/me');
      if (response.data['success'] == true) {
        return response.data['data'];
      } else {
        throw Exception(response.data['message'] ?? 'Failed to get profile');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message ?? 'Network error');
    }
  }

  Future<void> logout() async {
    await _client.clearTokens();
  }

  Future<void> forgotPassword(String email) async {
    try {
      final response = await _client.dio.post(
        'auth/forgot-password',
        data: {'email': email},
      );
      if (response.data['success'] == false) {
        throw Exception(response.data['message'] ?? 'Failed to send reset email');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message ?? 'Network error');
    }
  }
}