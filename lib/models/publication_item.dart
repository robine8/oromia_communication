class PublicationItem {
  final int id;
  final String title;
  final String? subtitle;
  final String? coverImage;
  final String type;
  final DateTime? publishedAt;
  final int pageCount;
  final int? issueNumber;
  final String? description;

  PublicationItem({
    required this.id,
    required this.title,
    this.subtitle,
    this.coverImage,
    required this.type,
    this.publishedAt,
    this.pageCount = 0,
    this.issueNumber,
    this.description,
  });

  factory PublicationItem.fromJson(Map<String, dynamic> json) {
    return PublicationItem(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      subtitle: json['subtitle'],
      coverImage: json['cover_image'] ?? json['thumbnail'],
      type: json['type'] ?? '',
      publishedAt: json['published_at'] != null
          ? DateTime.tryParse(json['published_at'])
          : null,
      pageCount: json['page_count'] ?? 0,
      issueNumber: json['issue_number'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'cover_image': coverImage,
      'type': type,
      'published_at': publishedAt?.toIso8601String(),
      'page_count': pageCount,
      'issue_number': issueNumber,
      'description': description,
    };
  }
}