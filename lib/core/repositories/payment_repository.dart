import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../network/api_client.dart';

class PaymentRepository {
  final ApiClient _client;

  PaymentRepository(this._client);

  Future<List<Map<String, dynamic>>> gateways() async {
    try {
      final response = await _client.dio.get('payment/gateways');
      if (response.data['success'] == true) {
        return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
      }
      return [];
    } on DioException catch (e) {
      debugPrint('Error fetching gateways: ${e.message}');
      return [];
    }
  }

  Future<Map<String, dynamic>> checkout({
    required int shopId,
    required String gateway,
    required String phone,
  }) async {
    try {
      final response = await _client.dio.post(
        'payment/checkout',
        data: {
          'shop_id': shopId,
          'gateway': gateway,
          'phone': phone,
        },
      );
      if (response.data['success'] == true) {
        return response.data['data'];
      } else {
        throw Exception(response.data['message'] ?? 'Checkout failed');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message ?? 'Checkout failed');
    }
  }

  Future<Map<String, dynamic>> status(String orderId) async {
    try {
      final response = await _client.dio.get('payment/status/$orderId');
      if (response.data['success'] == true) {
        return response.data['data'];
      } else {
        throw Exception(response.data['message'] ?? 'Failed to get payment status');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message ?? 'Failed to get payment status');
    }
  }
}