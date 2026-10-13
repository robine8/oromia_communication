import '../../models/government_models.dart';

class GovernmentRepository {
  // TODO: Confirm government endpoints with backend team
  // These methods currently use mock data - replace with API calls once endpoints are confirmed

  Future<List<RegionalSector>> getRegionalSectors() async {
    // TODO: Replace with API call when endpoint is confirmed
    // GET /api/v1/government/regional-sectors or similar
    // For now, return mock data
    await Future.delayed(const Duration(milliseconds: 300));
    return GovernmentMockData.getRegionalSectors();
  }

  Future<List<GovRegion>> getZones() async {
    // TODO: Replace with API call when endpoint is confirmed
    // GET /api/v1/government/zones or similar
    await Future.delayed(const Duration(milliseconds: 300));
    return GovernmentMockData.getZones();
  }

  Future<List<GovRegion>> getWoredasByZone(int zoneId) async {
    // TODO: Replace with API call when endpoint is confirmed
    // GET /api/v1/government/zones/$zoneId/woredas
    await Future.delayed(const Duration(milliseconds: 300));
    return GovernmentMockData.getWoredas(zoneId);
  }

  Future<List<GovRegion>> getCities() async {
    // TODO: Replace with API call when endpoint is confirmed
    // GET /api/v1/government/cities
    await Future.delayed(const Duration(milliseconds: 300));
    return GovernmentMockData.getCities();
  }

  Future<List<GovRegion>> getSubCitiesByCity(int cityId) async {
    // TODO: Replace with API call when endpoint is confirmed
    // GET /api/v1/government/cities/$cityId/sub-cities
    await Future.delayed(const Duration(milliseconds: 300));
    return GovernmentMockData.getSubCities(cityId);
  }

  Future<List<GovRegion>> getKebelesByParent(int parentId, String parentType) async {
    // TODO: Replace with API call when endpoint is confirmed
    // GET /api/v1/government/$parentType/$parentId/kebeles
    await Future.delayed(const Duration(milliseconds: 300));
    return GovernmentMockData.getKebeles(parentId, parentType);
  }

  Future<GovRegion> getRegionDetail(int id, String type) async {
    // TODO: Replace with API call when endpoint is confirmed
    // GET /api/v1/government/$type/$id
    await Future.delayed(const Duration(milliseconds: 200));
    return GovRegion(
      id: id,
      name: 'Detail for $type $id',
      type: type,
      childCount: 0,
      contactInfo: 'Contact information for $type $id',
    );
  }
}