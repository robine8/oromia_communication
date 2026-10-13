import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/repositories/publication_repository.dart';
import '../models/publication_item.dart';

final publicationRepositoryProvider = Provider<PublicationRepository>((ref) {
  return PublicationRepository();
});

final publicationListProvider = FutureProvider.family<List<PublicationItem>, String>((ref, type) async {
  final repo = ref.watch(publicationRepositoryProvider);
  return await repo.catalog(type: type);
});