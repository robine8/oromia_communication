import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/repositories/media_repository.dart';
import '../models/media_item.dart';

final mediaRepositoryProvider = Provider<MediaRepository>((ref) {
  return MediaRepository();
});

final mediaListProvider = FutureProvider.family<List<MediaItem>, String>((ref, type) async {
  final repo = ref.watch(mediaRepositoryProvider);
  return await repo.list(type: type);
});

final mediaDetailProvider = FutureProvider.family<MediaItem, Map<String, dynamic>>((ref, params) async {
  final repo = ref.watch(mediaRepositoryProvider);
  final id = params['id'] as int;
  final type = params['type'] as String;
  return await repo.detail(id, type);
});