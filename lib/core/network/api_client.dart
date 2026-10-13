import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';

class ApiClient {
  // Use CORS proxy for development
  static const String baseUrl = 'https://cors-anywhere.herokuapp.com/https://www.oromiacommunication.gov.et/api/v1/';

  late Dio _dio;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  String? _deviceId;

  // Token getters/setters
  String? get accessToken =>
      _dio.options.headers['Authorization']?.toString().replaceFirst('Bearer ', '');

  ApiClient() {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ));

    // Add interceptors
    _dio.interceptors.add(_authInterceptor);
    _dio.interceptors.add(_deviceIdInterceptor);
    _dio.interceptors.add(_loggingInterceptor);
  }

  Dio get dio => _dio;

  // === INTERCEPTORS ===

  Interceptor get _authInterceptor => InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Add X-APP-KEY (from dart-define)
          const appKey = String.fromEnvironment(
            'OCB_APP_KEY',
            defaultValue: 'ocb_flutter_app_key_7f3a9c2e1b8d4e6f0a5c9d2e8b1f4a7c',
          );
          options.headers['X-APP-KEY'] = appKey;

          // Add X-APP-VERSION
          options.headers['X-APP-VERSION'] = '1.0.0+1';

          // Add Bearer token if present
          final token = await _storage.read(key: 'access_token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          return handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            final refreshToken = await _storage.read(key: 'refresh_token');
            if (refreshToken != null) {
              try {
                // Use isolated Dio instance to avoid infinite 401 loop
                final refreshDio = Dio(BaseOptions(baseUrl: baseUrl));
                final response = await refreshDio.post(
                  'auth/refresh',
                  data: {'refresh_token': refreshToken},
                );

                if (response.data['success'] == true) {
                  final data = response.data['data'];
                  await _storage.write(key: 'access_token', value: data['access_token']);
                  await _storage.write(key: 'refresh_token', value: data['refresh_token']);

                  // Retry original request
                  final requestOptions = error.requestOptions;
                  requestOptions.headers['Authorization'] = 'Bearer ${data['access_token']}';

                  final retryResponse = await _dio.fetch(requestOptions);
                  return handler.resolve(retryResponse);
                }
              } catch (e) {
                await clearTokens();
              }
            }
          }
          return handler.next(error);
        },
      );

  Interceptor get _deviceIdInterceptor => InterceptorsWrapper(
        onRequest: (options, handler) async {
          final deviceId = await _getDeviceId();
          options.headers['X-DEVICE-ID'] = deviceId;
          return handler.next(options);
        },
      );

  Interceptor get _loggingInterceptor => InterceptorsWrapper(
        onRequest: (options, handler) {
          debugPrint('📤 Request: ${options.method} ${options.uri}');
          debugPrint('📤 Headers: ${options.headers}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          debugPrint('📥 Response: ${response.statusCode}');
          return handler.next(response);
        },
        onError: (error, handler) {
          debugPrint('❌ Error: ${error.message}');
          debugPrint('❌ Response: ${error.response?.data}');
          return handler.next(error);
        },
      );

  // === HELPERS ===

  Future<String> _getDeviceId() async {
    if (_deviceId != null) return _deviceId!;

    _deviceId = await _storage.read(key: 'device_id');
    if (_deviceId == null) {
      _deviceId = const Uuid().v4();
      await _storage.write(key: 'device_id', value: _deviceId);
    }
    return _deviceId!;
  }

  Future<void> setTokens(String accessToken, String refreshToken) async {
    await _storage.write(key: 'access_token', value: accessToken);
    await _storage.write(key: 'refresh_token', value: refreshToken);
    _dio.options.headers['Authorization'] = 'Bearer $accessToken';
  }

  Future<void> clearTokens() async {
    await _storage.delete(key: 'access_token');
    await _storage.delete(key: 'refresh_token');
    _dio.options.headers.remove('Authorization');
  }

  Future<bool> get isLoggedIn async {
    final token = await _storage.read(key: 'access_token');
    return token != null;
  }
}