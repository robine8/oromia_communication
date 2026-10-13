import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../network/api_client.dart';

class NewsRepository {
  final ApiClient _client;

  NewsRepository(this._client);

  Future<List<Map<String, dynamic>>> categories() async {
    try {
      final response = await _client.dio.get('news/categories');
      if (response.data['success'] == true) {
        return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
      }
      return [];
    } on DioException catch (e) {
      debugPrint('Error fetching categories: ${e.message}');
      return [];
    }
  }

  Future<Map<String, dynamic>> list({
    int page = 1,
    int limit = 20,
    String? category,
    String? query,
    String? language = 'en',
  }) async {
    try {
      final response = await _client.dio.get(
        'news',
        queryParameters: {
          'page': page,
          'limit': limit,
          if (category != null) 'category': category,
          if (query != null) 'q': query,
        },
        options: Options(
          headers: {'Accept-Language': language},
        ),
      );
      return response.data;
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message ?? 'Failed to load news');
    }
  }

  Future<Map<String, dynamic>> detail(int id, {String? language = 'en'}) async {
    try {
      final response = await _client.dio.get(
        'news/$id',
        options: Options(
          headers: {'Accept-Language': language},
        ),
      );
      if (response.data['success'] == true) {
        return response.data['data'];
      } else {
        throw Exception(response.data['message'] ?? 'News not found');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message ?? 'Failed to load news detail');
    }
  }
}