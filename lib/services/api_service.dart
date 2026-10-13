import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/news_model.dart';

class ApiService {
  // Your backend API
  static const String baseUrl = 'https://www.oromiacommunication.gov.et/api/v1';

  // API key
  static const String appKey =
      'ocb_flutter_app_key_7f3a9c2e1b8d4e6f0a5c9d2e8b1f4a7c';

  // ------------------------------------------------------------
  // Common headers
  // ------------------------------------------------------------

  Map<String, String> get _headers {
    return {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'X-APP-KEY': appKey,
      'Accept-Language': 'om',
    };
  }

  // ------------------------------------------------------------
  // GET NEWS
  // ------------------------------------------------------------

  Future<List<NewsModel>> getNews({
    int page = 1,
    int limit = 20,
    String? category,
    String? search,
  }) async {
    try {
      final queryParameters = <String, String>{
        'page': page.toString(),
        'limit': limit.toString(),
      };

      if (category != null && category.isNotEmpty) {
        queryParameters['category'] = category;
      }

      if (search != null && search.isNotEmpty) {
        queryParameters['q'] = search;
      }

      final uri = Uri.parse('$baseUrl/news').replace(
        queryParameters: queryParameters,
      );

      print('GET NEWS: $uri');

      final response = await http.get(
        uri,
        headers: _headers,
      );

      print('NEWS STATUS: ${response.statusCode}');
      print('NEWS RESPONSE: ${response.body}');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final decoded = jsonDecode(response.body);

        // Expected:
        // {
        //   "success": true,
        //   "message": "...",
        //   "data": [...]
        // }

        dynamic data = decoded['data'];

        if (data is Map<String, dynamic>) {
          // In case API returns:
          // data: {
          //   "items": [...]
          // }

          data = data['items'] ?? data['news'] ?? data['results'] ?? [];
        }

        if (data is List) {
          return data
              .map(
                (item) => NewsModel.fromJson(
                  Map<String, dynamic>.from(item),
                ),
              )
              .toList();
        }

        return [];
      }

      throw Exception(
        'Failed to load news: ${response.statusCode}',
      );
    } catch (e) {
      print('GET NEWS ERROR: $e');
      rethrow;
    }
  }

  // ------------------------------------------------------------
  // NEWS DETAIL
  // ------------------------------------------------------------

  Future<NewsModel> getNewsDetail(
    int id, {
    String language = 'om',
  }) async {
    try {
      final uri = Uri.parse('$baseUrl/news/$id');

      final headers = {
        ..._headers,
        'Accept-Language': language,
      };

      print('GET NEWS DETAIL: $uri');

      final response = await http.get(
        uri,
        headers: headers,
      );

      print('DETAIL STATUS: ${response.statusCode}');
      print('DETAIL RESPONSE: ${response.body}');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final decoded = jsonDecode(response.body);

        final data = decoded['data'];

        if (data is Map<String, dynamic>) {
          return NewsModel.fromJson(data);
        }

        throw Exception('Invalid news detail response');
      }

      throw Exception(
        'Failed to load news detail: ${response.statusCode}',
      );
    } catch (e) {
      print('NEWS DETAIL ERROR: $e');
      rethrow;
    }
  }

  // ------------------------------------------------------------
  // CATEGORIES
  // ------------------------------------------------------------

  Future<List<dynamic>> getCategories() async {
    try {
      final uri = Uri.parse('$baseUrl/news/categories');

      final response = await http.get(
        uri,
        headers: _headers,
      );

      print('CATEGORIES STATUS: ${response.statusCode}');
      print('CATEGORIES RESPONSE: ${response.body}');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final decoded = jsonDecode(response.body);

        final data = decoded['data'];

        if (data is List) {
          return data;
        }

        return [];
      }

      throw Exception(
        'Failed to load categories: ${response.statusCode}',
      );
    } catch (e) {
      print('CATEGORIES ERROR: $e');
      rethrow;
    }
  }
}
