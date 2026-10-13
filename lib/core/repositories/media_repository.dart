import '../../models/media_item.dart';

class MediaRepository {
  // TODO: Replace with real API call once backend confirms endpoints
  // Expected endpoints: GET /api/v1/media/{type}?page=&limit=

  Future<List<MediaItem>> list({
    required String type,
    int page = 1,
    int limit = 20,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Return mock data based on type
    return _getMockMedia(type);
  }

  Future<MediaItem> detail(int id, String type) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final items = _getMockMedia(type);
    return items.firstWhere(
      (item) => item.id == id,
      orElse: () => items.first,
    );
  }

  List<MediaItem> _getMockMedia(String type) {
    switch (type) {
      case 'press-release':
        return _getPressReleases();
      case 'documentary':
        return _getDocumentaries();
      case 'video':
        return _getVideos();
      case 'image-gallery':
        return _getGalleries();
      case 'audio-files':
        return _getAudioFiles();
      default:
        return [];
    }
  }

  List<MediaItem> _getPressReleases() {
    return [
      MediaItem(
        id: 1,
        title: 'Oromia Government Announces New Development Initiative',
        description: 'The Oromia Regional Government has announced a comprehensive development initiative...',
        thumbnailUrl: 'https://picsum.photos/seed/pr1/400/300',
        type: 'press-release',
        publishedAt: DateTime.now().subtract(const Duration(days: 1)),
        viewCount: 45,
      ),
      MediaItem(
        id: 2,
        title: 'Health Sector Reform Program Launched',
        description: 'A new health sector reform program has been launched to improve healthcare access...',
        thumbnailUrl: 'https://picsum.photos/seed/pr2/400/300',
        type: 'press-release',
        publishedAt: DateTime.now().subtract(const Duration(days: 3)),
        viewCount: 32,
      ),
      MediaItem(
        id: 3,
        title: 'Education Infrastructure Development Plan',
        description: 'The government has unveiled a plan to build 50 new schools across the region...',
        thumbnailUrl: 'https://picsum.photos/seed/pr3/400/300',
        type: 'press-release',
        publishedAt: DateTime.now().subtract(const Duration(days: 5)),
        viewCount: 28,
      ),
      MediaItem(
        id: 4,
        title: 'Agricultural Innovation Program',
        description: 'A new agricultural innovation program aims to support smallholder farmers...',
        thumbnailUrl: 'https://picsum.photos/seed/pr4/400/300',
        type: 'press-release',
        publishedAt: DateTime.now().subtract(const Duration(days: 7)),
        viewCount: 19,
      ),
      MediaItem(
        id: 5,
        title: 'Water Resource Management Strategy',
        description: 'A comprehensive water resource management strategy has been adopted...',
        thumbnailUrl: 'https://picsum.photos/seed/pr5/400/300',
        type: 'press-release',
        publishedAt: DateTime.now().subtract(const Duration(days: 10)),
        viewCount: 15,
      ),
    ];
  }

  List<MediaItem> _getDocumentaries() {
    return [
      MediaItem(
        id: 1,
        title: 'The Oromo Heritage',
        description: 'Exploring the rich cultural heritage of the Oromo people...',
        thumbnailUrl: 'https://picsum.photos/seed/doc1/400/300',
        mediaUrl: 'https://sample-videos.com/video321/mp4/480/big_buck_bunny_480p_1mb.mp4',
        type: 'documentary',
        publishedAt: DateTime.now().subtract(const Duration(days: 2)),
        viewCount: 89,
      ),
      MediaItem(
        id: 2,
        title: 'Journey Through Oromia',
        description: 'A journey through the diverse landscapes and cultures of Oromia...',
        thumbnailUrl: 'https://picsum.photos/seed/doc2/400/300',
        mediaUrl: 'https://sample-videos.com/video321/mp4/480/big_buck_bunny_480p_1mb.mp4',
        type: 'documentary',
        publishedAt: DateTime.now().subtract(const Duration(days: 6)),
        viewCount: 67,
      ),
      MediaItem(
        id: 3,
        title: 'Traditional Music and Dance',
        description: 'Exploring the traditional music and dance forms of Oromia...',
        thumbnailUrl: 'https://picsum.photos/seed/doc3/400/300',
        mediaUrl: 'https://sample-videos.com/video321/mp4/480/big_buck_bunny_480p_1mb.mp4',
        type: 'documentary',
        publishedAt: DateTime.now().subtract(const Duration(days: 12)),
        viewCount: 54,
      ),
      MediaItem(
        id: 4,
        title: 'Oromia\'s Natural Wonders',
        description: 'Exploring the natural beauty and wildlife of Oromia...',
        thumbnailUrl: 'https://picsum.photos/seed/doc4/400/300',
        mediaUrl: 'https://sample-videos.com/video321/mp4/480/big_buck_bunny_480p_1mb.mp4',
        type: 'documentary',
        publishedAt: DateTime.now().subtract(const Duration(days: 18)),
        viewCount: 42,
      ),
    ];
  }

  List<MediaItem> _getVideos() {
    return [
      MediaItem(
        id: 1,
        title: 'Oromo Culture Festival 2024 Highlights',
        description: 'Highlights from the annual Oromo Culture Festival...',
        thumbnailUrl: 'https://picsum.photos/seed/vid1/400/300',
        mediaUrl: 'https://sample-videos.com/video321/mp4/480/big_buck_bunny_480p_1mb.mp4',
        type: 'video',
        publishedAt: DateTime.now().subtract(const Duration(days: 1)),
        viewCount: 156,
      ),
      MediaItem(
        id: 2,
        title: 'Community Development Project',
        description: 'Community development project in rural Oromia...',
        thumbnailUrl: 'https://picsum.photos/seed/vid2/400/300',
        mediaUrl: 'https://sample-videos.com/video321/mp4/480/big_buck_bunny_480p_1mb.mp4',
        type: 'video',
        publishedAt: DateTime.now().subtract(const Duration(days: 4)),
        viewCount: 98,
      ),
      MediaItem(
        id: 3,
        title: 'Young Innovators Showcase',
        description: 'Young innovators showcasing their projects...',
        thumbnailUrl: 'https://picsum.photos/seed/vid3/400/300',
        mediaUrl: 'https://sample-videos.com/video321/mp4/480/big_buck_bunny_480p_1mb.mp4',
        type: 'video',
        publishedAt: DateTime.now().subtract(const Duration(days: 8)),
        viewCount: 73,
      ),
      MediaItem(
        id: 4,
        title: 'Environmental Conservation Efforts',
        description: 'Efforts to conserve the environment in Oromia...',
        thumbnailUrl: 'https://picsum.photos/seed/vid4/400/300',
        mediaUrl: 'https://sample-videos.com/video321/mp4/480/big_buck_bunny_480p_1mb.mp4',
        type: 'video',
        publishedAt: DateTime.now().subtract(const Duration(days: 14)),
        viewCount: 61,
      ),
      MediaItem(
        id: 5,
        title: 'Public Health Awareness Campaign',
        description: 'Public health awareness campaign in communities...',
        thumbnailUrl: 'https://picsum.photos/seed/vid5/400/300',
        mediaUrl: 'https://sample-videos.com/video321/mp4/480/big_buck_bunny_480p_1mb.mp4',
        type: 'video',
        publishedAt: DateTime.now().subtract(const Duration(days: 20)),
        viewCount: 44,
      ),
    ];
  }

  List<MediaItem> _getGalleries() {
    return [
      MediaItem(
        id: 1,
        title: 'Oromo Cultural Heritage Exhibition',
        description: 'Photos from the cultural heritage exhibition...',
        thumbnailUrl: 'https://picsum.photos/seed/gal1/400/400',
        type: 'image-gallery',
        publishedAt: DateTime.now().subtract(const Duration(days: 2)),
        viewCount: 34,
        imageUrls: [
          'https://picsum.photos/seed/gal1_1/800/600',
          'https://picsum.photos/seed/gal1_2/800/600',
          'https://picsum.photos/seed/gal1_3/800/600',
          'https://picsum.photos/seed/gal1_4/800/600',
          'https://picsum.photos/seed/gal1_5/800/600',
        ],
      ),
      MediaItem(
        id: 2,
        title: 'Annual Community Festival',
        description: 'Photos from the annual community festival...',
        thumbnailUrl: 'https://picsum.photos/seed/gal2/400/400',
        type: 'image-gallery',
        publishedAt: DateTime.now().subtract(const Duration(days: 5)),
        viewCount: 28,
        imageUrls: [
          'https://picsum.photos/seed/gal2_1/800/600',
          'https://picsum.photos/seed/gal2_2/800/600',
          'https://picsum.photos/seed/gal2_3/800/600',
          'https://picsum.photos/seed/gal2_4/800/600',
        ],
      ),
      MediaItem(
        id: 3,
        title: 'Development Projects Showcase',
        description: 'Photos showcasing development projects...',
        thumbnailUrl: 'https://picsum.photos/seed/gal3/400/400',
        type: 'image-gallery',
        publishedAt: DateTime.now().subtract(const Duration(days: 9)),
        viewCount: 19,
        imageUrls: [
          'https://picsum.photos/seed/gal3_1/800/600',
          'https://picsum.photos/seed/gal3_2/800/600',
          'https://picsum.photos/seed/gal3_3/800/600',
          'https://picsum.photos/seed/gal3_4/800/600',
          'https://picsum.photos/seed/gal3_5/800/600',
          'https://picsum.photos/seed/gal3_6/800/600',
        ],
      ),
    ];
  }

  List<MediaItem> _getAudioFiles() {
    return [
      MediaItem(
        id: 1,
        title: 'Oromo Traditional Music',
        description: 'Traditional music from Oromia region...',
        thumbnailUrl: 'https://picsum.photos/seed/aud1/400/300',
        type: 'audio-files',
        publishedAt: DateTime.now().subtract(const Duration(days: 1)),
        viewCount: 23,
        duration: 245,
      ),
      MediaItem(
        id: 2,
        title: 'Community Radio Interview',
        description: 'Interview with community leaders...',
        thumbnailUrl: 'https://picsum.photos/seed/aud2/400/300',
        type: 'audio-files',
        publishedAt: DateTime.now().subtract(const Duration(days: 4)),
        viewCount: 18,
        duration: 180,
      ),
      MediaItem(
        id: 3,
        title: 'Oromo Poetry Reading',
        description: 'Traditional Oromo poetry reading...',
        thumbnailUrl: 'https://picsum.photos/seed/aud3/400/300',
        type: 'audio-files',
        publishedAt: DateTime.now().subtract(const Duration(days: 8)),
        viewCount: 14,
        duration: 320,
      ),
      MediaItem(
        id: 4,
        title: 'Cultural Heritage Discussion',
        description: 'Discussion on preserving cultural heritage...',
        thumbnailUrl: 'https://picsum.photos/seed/aud4/400/300',
        type: 'audio-files',
        publishedAt: DateTime.now().subtract(const Duration(days: 12)),
        viewCount: 9,
        duration: 540,
      ),
      MediaItem(
        id: 5,
        title: 'Youth Voices Podcast',
        description: 'Youth voices on community development...',
        thumbnailUrl: 'https://picsum.photos/seed/aud5/400/300',
        type: 'audio-files',
        publishedAt: DateTime.now().subtract(const Duration(days: 18)),
        viewCount: 7,
        duration: 425,
      ),
    ];
  }
}