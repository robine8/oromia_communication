class Publication {
  final String id;
  final String title;
  final String content;
  final String type;
  final String? imageUrl;
  final String? author;
  final String? date;
  final String? category;

  Publication({
    required this.id,
    required this.title,
    required this.content,
    required this.type,
    this.imageUrl,
    this.author,
    this.date,
    this.category,
  });

  factory Publication.fromJson(Map<String, dynamic> json) {
    return Publication(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? json['description'] ?? '',
      type: json['type'] ?? json['typeSlug'] ?? '',
      imageUrl: json['imageUrl'] ?? json['image'] ?? json['thumbnail'],
      author: json['author'],
      date: json['date'] ?? json['publishedAt'],
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'type': type,
      'imageUrl': imageUrl,
      'author': author,
      'date': date,
      'category': category,
    };
  }
}
