class MediaItem {
  final String id;
  final String title;
  final String type; // 'image', 'video', 'audio'
  final String url;
  final String? thumbnail;
  final DateTime? publishedAt;

  MediaItem({
    required this.id,
    required this.title,
    required this.type,
    required this.url,
    this.thumbnail,
    this.publishedAt,
  });

  factory MediaItem.fromJson(Map<String, dynamic> json) {
    return MediaItem(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      type: json['type'] ?? 'image',
      url: json['url'] ?? '',
      thumbnail: json['thumbnail'] ?? json['imageUrl'],
      publishedAt: json['publishedAt'] != null
          ? DateTime.parse(json['publishedAt'])
          : null,
    );
  }
}
