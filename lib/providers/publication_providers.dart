import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/publication_repository.dart';
import '../api/ocb_api.dart';

final ocbApiProvider = Provider<OcbApi>((ref) {
  return OcbApi();
});

final publicationRepositoryProvider = Provider<PublicationRepository>((ref) {
  final api = ref.watch(ocbApiProvider);
  return PublicationRepository(api);
});
