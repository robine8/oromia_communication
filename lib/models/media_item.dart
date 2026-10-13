class MediaItem {
  final int id;
  final String title;
  final String? description;
  final String? thumbnailUrl;
  final String? mediaUrl;
  final String? fileUrl;
  final String type;
  final DateTime? publishedAt;
  final int viewCount;
  final int? duration; // For audio/video in seconds
  final List<String>? imageUrls; // For galleries

  MediaItem({
    required this.id,
    required this.title,
    this.description,
    this.thumbnailUrl,
    this.mediaUrl,
    this.fileUrl,
    required this.type,
    this.publishedAt,
    this.viewCount = 0,
    this.duration,
    this.imageUrls,
  });

  factory MediaItem.fromJson(Map<String, dynamic> json) {
    return MediaItem(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'],
      thumbnailUrl: json['thumbnail_url'] ?? json['image_url'],
      mediaUrl: json['media_url'],
      fileUrl: json['file_url'],
      type: json['type'] ?? '',
      publishedAt: json['published_at'] != null
          ? DateTime.tryParse(json['published_at'])
          : null,
      viewCount: json['view_count'] ?? 0,
      duration: json['duration'],
      imageUrls: json['image_urls'] != null
          ? List<String>.from(json['image_urls'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'thumbnail_url': thumbnailUrl,
      'media_url': mediaUrl,
      'file_url': fileUrl,
      'type': type,
      'published_at': publishedAt?.toIso8601String(),
      'view_count': viewCount,
      'duration': duration,
      'image_urls': imageUrls,
    };
  }
}