import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/repositories/government_repository.dart';
import '../models/government_models.dart';

final governmentRepositoryProvider = Provider<GovernmentRepository>((ref) {
  return GovernmentRepository();
});

final regionalSectorsProvider = FutureProvider<List<RegionalSector>>((ref) async {
  final repo = ref.watch(governmentRepositoryProvider);
  return await repo.getRegionalSectors();
});

final zonesProvider = FutureProvider<List<GovRegion>>((ref) async {
  final repo = ref.watch(governmentRepositoryProvider);
  return await repo.getZones();
});

final citiesProvider = FutureProvider<List<GovRegion>>((ref) async {
  final repo = ref.watch(governmentRepositoryProvider);
  return await repo.getCities();
});

final woredasProvider = FutureProvider.family<List<GovRegion>, int>((ref, zoneId) async {
  final repo = ref.watch(governmentRepositoryProvider);
  return await repo.getWoredasByZone(zoneId);
});

final subCitiesProvider = FutureProvider.family<List<GovRegion>, int>((ref, cityId) async {
  final repo = ref.watch(governmentRepositoryProvider);
  return await repo.getSubCitiesByCity(cityId);
});

final kebelesProvider = FutureProvider.family<List<GovRegion>, Map<String, dynamic>>((ref, params) async {
  final repo = ref.watch(governmentRepositoryProvider);
  final parentId = params['parentId'] as int;
  final parentType = params['parentType'] as String;
  return await repo.getKebelesByParent(parentId, parentType);
});