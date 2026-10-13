import 'package:oromia_communication_bureau/core/api/api_client.dart';
import 'package:oromia_communication_bureau/core/api/api_constants.dart';
import 'package:oromia_communication_bureau/core/api/api_response.dart';
import 'package:oromia_communication_bureau/models/news_model.dart';

class NewsRepository {
  final ApiClient _apiClient = ApiClient();

  Future<ApiResponse<List<NewsCategory>>> getCategories() async {
    try {
      final response = await _apiClient.get(
        ApiConstants.newsCategoriesEndpoint,
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        final List<dynamic> data = response.data['data'] ?? [];
        return ApiResponse<List<NewsCategory>>(
          success: true,
          message: 'Categories loaded successfully',
          data: data.map((json) => NewsCategory.fromJson(json)).toList(),
        );
      }

      return ApiResponse<List<NewsCategory>>.error(
        response.data['message'] ?? 'Failed to load categories',
      );
    } catch (e) {
      return ApiResponse<List<NewsCategory>>.error(e.toString());
    }
  }

  Future<ApiResponse<List<NewsModel>>> getNews({
    int page = 1,
    int limit = 20,
    String? category,
    String? query,
    String? language = 'om',
  }) async {
    try {
      final response = await _apiClient.get(
        ApiConstants.newsListEndpoint,
        queryParameters: {
          'page': page,
          'limit': limit,
          if (category != null && category != 'all') 'category': category,
          if (query != null && query.isNotEmpty) 'q': query,
        },
        options: Options(
          headers: {
            'Accept-Language': language,
          },
        ),
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        final List<dynamic> data = response.data['data'] ?? [];
        return ApiResponse<List<NewsModel>>(
          success: true,
          message: 'News loaded successfully',
          data: data.map((json) => NewsModel.fromJson(json)).toList(),
          meta: response.data['meta'],
        );
      }

      return ApiResponse<List<NewsModel>>.error(
        response.data['message'] ?? 'Failed to load news',
      );
    } catch (e) {
      return ApiResponse<List<NewsModel>>.error(e.toString());
    }
  }

  Future<ApiResponse<NewsModel>> getNewsDetail(int id) async {
    try {
      final response = await _apiClient.get(
        '${ApiConstants.newsDetailEndpoint}/$id',
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        return ApiResponse<NewsModel>(
          success: true,
          message: 'News detail loaded successfully',
          data: NewsModel.fromJson(response.data['data']),
        );
      }

      return ApiResponse<NewsModel>.error(
        response.data['message'] ?? 'Failed to load news detail',
      );
    } catch (e) {
      return ApiResponse<NewsModel>.error(e.toString());
    }
  }
}
