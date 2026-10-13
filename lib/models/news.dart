class News {
  final int id;
  final String title;
  final String? body;
  final String? imageUrl;
  final String? categoryName;
  final String? categorySlug;
  final DateTime? publishedAt;
  final int viewCount;
  final bool isFeatured;

  News({
    required this.id,
    required this.title,
    this.body,
    this.imageUrl,
    this.categoryName,
    this.categorySlug,
    this.publishedAt,
    required this.viewCount,
    this.isFeatured = false,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      body: json['body'] ?? json['content'],
      imageUrl: json['image_url'] ?? json['featured_image'],
      categoryName: json['category_name'] ?? '',
      categorySlug: json['category_slug'] ?? '',
      publishedAt: json['published_at'] != null 
          ? DateTime.tryParse(json['published_at']) 
          : null,
      viewCount: json['view_count'] ?? 0,
      isFeatured: json['is_featured'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'image_url': imageUrl,
      'category_name': categoryName,
      'category_slug': categorySlug,
      'published_at': publishedAt?.toIso8601String(),
      'view_count': viewCount,
      'is_featured': isFeatured,
    };
  }
}