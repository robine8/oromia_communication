import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'api_provider.dart';

final bootstrapProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final client = ref.watch(apiClientProvider);
  try {
    final response = await client.dio.get('home/bootstrap');
    return response.data['data'] ?? {};
  } catch (e) {
    debugPrint('Error loading bootstrap: $e');
    return {};
  }
});