import 'package:dio/dio.dart';
import '../core/api/api_client.dart';
import '../core/utils/app_logger.dart';
import '../models/news_model.dart';
import '../models/media_model.dart';

class OcbApi {
  final ApiClient _apiClient = ApiClient();

  // Mock data
  final List<Map<String, dynamic>> _mockPublications = [
    {
      'id': 1,
      'title': 'Bulletin January 2024',
      'content': 'This is the January 2024 bulletin content...',
      'type': 'bulletin',
      'typeSlug': 'bulletin',
      'imageUrl': 'https://via.placeholder.com/400x200',
      'author': 'OCB Editorial Team',
      'date': '2024-01-15',
    },
    {
      'id': 2,
      'title': 'Annual Report 2023',
      'content': 'This is the 2023 annual report content...',
      'type': 'archive',
      'typeSlug': 'archive',
      'imageUrl': 'https://via.placeholder.com/400x200',
      'author': 'OCB Research Team',
      'date': '2023-12-31',
    },
  ];

  final List<Map<String, dynamic>> _mockNews = [
    {
      'id': 1,
      'title': 'Oromia Development Conference 2024',
      'subtitle': 'Annual conference on regional development',
      'imageUrl': 'https://via.placeholder.com/400x200',
      'date': '2024-01-15',
      'category': 'Development',
      'content': 'Full news content here...',
    },
    {
      'id': 2,
      'title': 'New Education Initiative Launch',
      'subtitle': 'Government announces new education program',
      'imageUrl': 'https://via.placeholder.com/400x200',
      'date': '2024-01-10',
      'category': 'Education',
      'content': 'Full news content here...',
    },
  ];

  final List<Map<String, dynamic>> _mockMedia = [
    {
      'id': '1',
      'title': 'Opening Ceremony',
      'type': 'video',
      'url': 'https://www.example.com/video1.mp4',
      'thumbnail': 'https://via.placeholder.com/400x200',
      'publishedAt': '2024-01-15T10:00:00Z',
    },
    {
      'id': '2',
      'title': 'Conference Photos',
      'type': 'image',
      'url': 'https://via.placeholder.com/800x600',
      'thumbnail': 'https://via.placeholder.com/400x200',
      'publishedAt': '2024-01-14T10:00:00Z',
    },
  ];

  // Publication methods
  Future<List<Map<String, dynamic>>> getPublications(String type) async {
    await Future.delayed(const Duration(seconds: 1));
    return _mockPublications
        .where((pub) => pub['type'] == type || pub['typeSlug'] == type)
        .toList();
  }

  // News methods
  Future<List<Map<String, dynamic>>> getNews({
    int page = 1,
    int limit = 20,
    String? query,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    var results = _mockNews;
    if (query != null && query.isNotEmpty) {
      results = results
          .where(
            (news) =>
                news['title']?.toLowerCase().contains(query.toLowerCase()) ??
                false,
          )
          .toList();
    }
    return results;
  }

  // Media methods
  Future<List<Map<String, dynamic>>> getMedia({
    int page = 1,
    int limit = 20,
    String? type,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    var results = _mockMedia;
    if (type != null && type.isNotEmpty) {
      results = results.where((m) => m['type'] == type).toList();
    }
    return results;
  }
}
