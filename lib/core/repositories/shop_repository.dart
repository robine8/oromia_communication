import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../network/api_client.dart';

class ShopRepository {
  final ApiClient _client;

  ShopRepository(this._client);

  Future<Map<String, dynamic>> list({
    int page = 1,
    int limit = 20,
    String? query,
  }) async {
    try {
      final response = await _client.dio.get(
        'shop',
        queryParameters: {
          'page': page,
          'limit': limit,
          if (query != null) 'q': query,
        },
      );
      return response.data;
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message ?? 'Failed to load shop');
    }
  }

  Future<Map<String, dynamic>> detail(int id) async {
    try {
      final response = await _client.dio.get('shop/$id');
      if (response.data['success'] == true) {
        return response.data['data'];
      } else {
        throw Exception(response.data['message'] ?? 'Shop item not found');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message ?? 'Failed to load shop detail');
    }
  }

  Future<bool> owned(int id) async {
    try {
      final response = await _client.dio.get('shop/$id/owned');
      return response.data['success'] == true && response.data['data']?['owned'] == true;
    } on DioException catch (e) {
      debugPrint('Error checking ownership: ${e.message}');
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> history() async {
    try {
      final response = await _client.dio.get('shop/history');
      if (response.data['success'] == true) {
        return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
      }
      return [];
    } on DioException catch (e) {
      debugPrint('Error fetching purchase history: ${e.message}');
      return [];
    }
  }
}