import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../network/api_client.dart';

class ReaderRepository {
  final ApiClient _client;

  ReaderRepository(this._client);

  Future<Map<String, dynamic>> catalog({
    required String type,
    int page = 1,
  }) async {
    try {
      final response = await _client.dio.get(
        'read/catalog',
        queryParameters: {
          'type': type,
          'page': page,
        },
      );
      return response.data;
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message ?? 'Failed to load catalog');
    }
  }

  Future<Map<String, dynamic>> startSession({
    required String type,
    required int bookId,
  }) async {
    try {
      final response = await _client.dio.post(
        'read/session',
        data: {
          'type': type,
          'book_id': bookId,
        },
      );
      if (response.data['success'] == true) {
        return response.data['data'];
      } else {
        throw Exception(response.data['message'] ?? 'Failed to start reading session');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message ?? 'Failed to start reading session');
    }
  }

  Future<void> saveProgress({
    required String type,
    required int bookId,
    required int page,
    required int pageCount,
  }) async {
    try {
      await _client.dio.post(
        'read/progress',
        data: {
          'type': type,
          'book_id': bookId,
          'page': page,
          'page_count': pageCount,
        },
      );
    } on DioException catch (e) {
      debugPrint('Error saving progress: ${e.message}');
    }
  }
}