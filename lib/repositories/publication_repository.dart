import '../api/ocb_api.dart';
import '../models/publication_model.dart';

class PublicationRepository {
  final OcbApi _api;

  PublicationRepository(this._api);

  Future<List<Publication>> getPublicationsByType(String type) async {
    try {
      final response = await _api.getPublications(type);
      return response.map((json) => Publication.fromJson(json)).toList();
    } catch (e) {
      AppLogger.error('Failed to get publications', e);
      return [];
    }
  }
}
