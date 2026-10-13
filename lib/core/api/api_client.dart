import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../utils/app_logger.dart';
import 'api_constants.dart';

class ApiClient {
  final Dio _dio;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  static const String _tokenKey = 'access_token';

  ApiClient()
    : _dio = Dio(
        BaseOptions(
          baseUrl: ApiConstants.baseUrl,
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      ) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: _onRequest,
        onResponse: _onResponse,
        onError: _onError,
      ),
    );
  }

  void _onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    AppLogger.debug('🚀 API Request: ${options.method} ${options.path}');
    _secureStorage
        .read(key: _tokenKey)
        .then((token) {
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        })
        .catchError((error) {
          AppLogger.error('Error reading token', error);
          handler.next(options);
        });
  }

  void _onResponse(Response response, ResponseInterceptorHandler handler) {
    AppLogger.debug(
      '✅ API Response: ${response.statusCode} ${response.requestOptions.path}',
    );
    handler.next(response);
  }

  void _onError(DioError error, ErrorInterceptorHandler handler) {
    AppLogger.error('❌ API Error: ${error.message}', error);
    handler.next(error);
  }

  Dio get dio => _dio;
}
