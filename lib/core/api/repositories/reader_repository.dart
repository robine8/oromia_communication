import 'package:oromia_communication_bureau/core/api/api_client.dart';
import 'package:oromia_communication_bureau/core/api/api_constants.dart';
import 'package:oromia_communication_bureau/core/api/api_response.dart';
import 'package:oromia_communication_bureau/models/reader_model.dart';

class ReaderRepository {
  final ApiClient _apiClient = ApiClient();

  Future<ApiResponse<ReaderSecurityPolicy>> getSecurityPolicy() async {
    try {
      final response = await _apiClient.get(
        ApiConstants.readerSecurityPolicyEndpoint,
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        return ApiResponse<ReaderSecurityPolicy>(
          success: true,
          message: 'Security policy loaded',
          data: ReaderSecurityPolicy.fromJson(response.data['data']),
        );
      }

      return ApiResponse<ReaderSecurityPolicy>.error(
        response.data['message'] ?? 'Failed to load security policy',
      );
    } catch (e) {
      return ApiResponse<ReaderSecurityPolicy>.error(e.toString());
    }
  }

  Future<ApiResponse<CatalogResponse>> getCatalog({
    String type = 'weekly',
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final response = await _apiClient.get(
        ApiConstants.readerCatalogEndpoint,
        queryParameters: {
          'type': type,
          'page': page,
          'limit': limit,
        },
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        return ApiResponse<CatalogResponse>(
          success: true,
          message: 'Catalog loaded successfully',
          data: CatalogResponse.fromJson(response.data['data']),
          meta: response.data['meta'],
        );
      }

      return ApiResponse<CatalogResponse>.error(
        response.data['message'] ?? 'Failed to load catalog',
      );
    } catch (e) {
      return ApiResponse<CatalogResponse>.error(e.toString());
    }
  }

  Future<ApiResponse<ReaderSession>> createSession({
    required String type,
    required int bookId,
  }) async {
    try {
      final response = await _apiClient.post(
        ApiConstants.readerSessionEndpoint,
        data: {
          'type': type,
          'book_id': bookId,
        },
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        return ApiResponse<ReaderSession>(
          success: true,
          message: 'Reader session created',
          data: ReaderSession.fromJson(response.data['data']),
        );
      }

      return ApiResponse<ReaderSession>.error(
        response.data['message'] ?? 'Failed to create reader session',
      );
    } catch (e) {
      return ApiResponse<ReaderSession>.error(e.toString());
    }
  }

  Future<ApiResponse<void>> updateProgress({
    required String type,
    required int bookId,
    required int page,
    required int pageCount,
  }) async {
    try {
      final response = await _apiClient.post(
        ApiConstants.readerProgressEndpoint,
        data: {
          'type': type,
          'book_id': bookId,
          'page': page,
          'page_count': pageCount,
        },
      );

      if (response.statusCode == 200) {
        return ApiResponse<void>(
          success: true,
          message: 'Progress updated',
        );
      }

      return ApiResponse<void>.error(
        response.data['message'] ?? 'Failed to update progress',
      );
    } catch (e) {
      return ApiResponse<void>.error(e.toString());
    }
  }

  String getPageUrl(String template, int page) {
    return template.replaceAll('{page}', page.toString());
  }
}
