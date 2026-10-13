import 'package:oromia_communication_bureau/core/api/api_client.dart';
import 'package:oromia_communication_bureau/core/api/api_constants.dart';
import 'package:oromia_communication_bureau/core/api/api_response.dart';

class ShopRepository {
  final ApiClient _apiClient = ApiClient();

  Future<ApiResponse<List<ShopItem>>> getShopItems({
    int page = 1,
    int limit = 20,
    String? query,
  }) async {
    try {
      final response = await _apiClient.get(
        ApiConstants.shopListEndpoint,
        queryParameters: {
          'page': page,
          'limit': limit,
          if (query != null && query.isNotEmpty) 'q': query,
        },
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        final List<dynamic> data = response.data['data'] ?? [];
        return ApiResponse<List<ShopItem>>(
          success: true,
          message: 'Shop items loaded',
          data: data.map((json) => ShopItem.fromJson(json)).toList(),
          meta: response.data['meta'],
        );
      }

      return ApiResponse<List<ShopItem>>.error(
        response.data['message'] ?? 'Failed to load shop items',
      );
    } catch (e) {
      return ApiResponse<List<ShopItem>>.error(e.toString());
    }
  }

  Future<ApiResponse<ShopItem>> getShopDetail(int id) async {
    try {
      final response = await _apiClient.get(
        '${ApiConstants.shopDetailEndpoint}/$id',
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        return ApiResponse<ShopItem>(
          success: true,
          message: 'Shop detail loaded',
          data: ShopItem.fromJson(response.data['data']),
        );
      }

      return ApiResponse<ShopItem>.error(
        response.data['message'] ?? 'Failed to load shop detail',
      );
    } catch (e) {
      return ApiResponse<ShopItem>.error(e.toString());
    }
  }
}

class ShopItem {
  final int id;
  final String title;
  final String description;
  final double price;
  final String? image;
  final bool purchased;
  final bool canRead;

  ShopItem({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    this.image,
    this.purchased = false,
    this.canRead = false,
  });

  factory ShopItem.fromJson(Map<String, dynamic> json) {
    return ShopItem(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      image: json['image'],
      purchased: json['purchased'] ?? false,
      canRead: json['can_read'] ?? false,
    );
  }
}
