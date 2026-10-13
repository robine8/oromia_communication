import 'package:oromia_communication_bureau/core/api/api_client.dart';
import 'package:oromia_communication_bureau/core/api/api_constants.dart';
import 'package:oromia_communication_bureau/core/api/api_response.dart';
import 'package:oromia_communication_bureau/core/api/token_manager.dart';
import 'package:oromia_communication_bureau/models/auth_model.dart';

class AuthRepository {
  final ApiClient _apiClient = ApiClient();
  final TokenManager _tokenManager = TokenManager();

  Future<ApiResponse<LoginResponse>> login({
    required String email,
    required String password,
    required String deviceName,
  }) async {
    try {
      final response = await _apiClient.post(
        ApiConstants.loginEndpoint,
        data: {
          'email': email,
          'password': password,
          'device_name': deviceName,
        },
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        final data = response.data['data'];
        await _tokenManager.saveTokens(
          data['access_token'],
          data['refresh_token'],
          data['expires_in'],
          data['refresh_expires_in'],
        );
        await _tokenManager.saveUser(data['user']);

        return ApiResponse<LoginResponse>(
          success: true,
          message: response.data['message'] ?? 'Login successful',
          data: LoginResponse.fromJson(data),
        );
      }

      return ApiResponse<LoginResponse>.error(
        response.data['message'] ?? 'Login failed',
      );
    } catch (e) {
      return ApiResponse<LoginResponse>.error(e.toString());
    }
  }

  Future<ApiResponse<RegisterResponse>> register({
    required String name,
    required String email,
    required String password,
    String? phone,
  }) async {
    try {
      final response = await _apiClient.post(
        ApiConstants.registerEndpoint,
        data: {
          'name': name,
          'email': email,
          'password': password,
          if (phone != null) 'phone': phone,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse<RegisterResponse>(
          success: response.data['success'] ?? true,
          message: response.data['message'] ?? 'Registration successful',
          data: RegisterResponse.fromJson(response.data['data']),
        );
      }

      return ApiResponse<RegisterResponse>.error(
        response.data['message'] ?? 'Registration failed',
      );
    } catch (e) {
      return ApiResponse<RegisterResponse>.error(e.toString());
    }
  }

  Future<ApiResponse<void>> logout() async {
    try {
      final refreshToken = await _tokenManager.getRefreshToken();
      if (refreshToken != null) {
        await _apiClient.post(
          ApiConstants.logoutEndpoint,
          data: {'refresh_token': refreshToken},
        );
      }
      await _tokenManager.clearTokens();
      return ApiResponse<void>(
        success: true,
        message: 'Logged out successfully',
      );
    } catch (e) {
      // Even if server logout fails, clear local tokens
      await _tokenManager.clearTokens();
      return ApiResponse<void>(
        success: true,
        message: 'Logged out locally',
      );
    }
  }

  Future<ApiResponse<User>> getCurrentUser() async {
    try {
      final response = await _apiClient.get(ApiConstants.meEndpoint);

      if (response.statusCode == 200) {
        return ApiResponse<User>(
          success: true,
          message: 'User fetched successfully',
          data: User.fromJson(response.data['data']),
        );
      }

      return ApiResponse<User>.error(
        response.data['message'] ?? 'Failed to fetch user',
      );
    } catch (e) {
      return ApiResponse<User>.error(e.toString());
    }
  }

  Future<bool> isAuthenticated() async {
    return await _tokenManager.isAuthenticated();
  }
}
