import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/news.dart';
import 'api_provider.dart';

final newsListProvider = FutureProvider.family<List<News>, String>((ref, category) async {
  final repo = ref.watch(newsRepositoryProvider);
  final response = await repo.list(
    category: category == 'all' ? null : category,
    limit: 10,
  );
  
  if (response['success'] == true) {
    final data = response['data'];
    if (data is List) {
      return data.map((item) => News.fromJson(item)).toList();
    }
  }
  return [];
});

final newsDetailProvider = FutureProvider.family<News, int>((ref, id) async {
  final repo = ref.watch(newsRepositoryProvider);
  final data = await repo.detail(id);
  return News.fromJson(data);
});

final categoriesProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final repo = ref.watch(newsRepositoryProvider);
  return await repo.categories();
});