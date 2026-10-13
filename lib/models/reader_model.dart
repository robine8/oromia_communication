class ReaderSecurityPolicy {
  final bool blockScreenshots;
  final bool androidFlagSecure;
  final bool iosScreenCaptureDetect;
  final bool watermark;
  final bool downloadAllowed;
  final bool shareAllowed;

  ReaderSecurityPolicy({
    required this.blockScreenshots,
    required this.androidFlagSecure,
    required this.iosScreenCaptureDetect,
    required this.watermark,
    required this.downloadAllowed,
    required this.shareAllowed,
  });

  factory ReaderSecurityPolicy.fromJson(Map<String, dynamic> json) {
    return ReaderSecurityPolicy(
      blockScreenshots: json['block_screenshots'] ?? false,
      androidFlagSecure: json['android_flag_secure'] ?? false,
      iosScreenCaptureDetect: json['ios_screen_capture_detect'] ?? false,
      watermark: json['watermark'] ?? false,
      downloadAllowed: json['download_allowed'] ?? false,
      shareAllowed: json['share_allowed'] ?? false,
    );
  }
}

class BookItem {
  final int id;
  final String title;
  final String? coverImage;
  final String? description;
  final String? author;
  final String? publishedAt;
  final int pageCount;

  BookItem({
    required this.id,
    required this.title,
    this.coverImage,
    this.description,
    this.author,
    this.publishedAt,
    required this.pageCount,
  });

  factory BookItem.fromJson(Map<String, dynamic> json) {
    return BookItem(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      coverImage: json['cover_image'],
      description: json['description'],
      author: json['author'],
      publishedAt: json['published_at'],
      pageCount: json['page_count'] ?? 0,
    );
  }
}

class CatalogResponse {
  final List<BookItem> items;
  final int total;

  CatalogResponse({
    required this.items,
    required this.total,
  });

  factory CatalogResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> data = json['items'] ?? json['data'] ?? [];
    return CatalogResponse(
      items: data.map((item) => BookItem.fromJson(item)).toList(),
      total: json['total'] ?? data.length,
    );
  }
}

class ReaderSession {
  final String sessionId;
  final String pageUrlTemplate;
  final String? streamUrl;
  final int pageCount;
  final int resumePage;
  final ReaderSecurityPolicy security;
  final bool canRead;

  ReaderSession({
    required this.sessionId,
    required this.pageUrlTemplate,
    this.streamUrl,
    required this.pageCount,
    required this.resumePage,
    required this.security,
    required this.canRead,
  });

  factory ReaderSession.fromJson(Map<String, dynamic> json) {
    return ReaderSession(
      sessionId: json['session_id'] ?? '',
      pageUrlTemplate: json['page_url_template'] ?? '',
      streamUrl: json['stream_url'],
      pageCount: json['page_count'] ?? 0,
      resumePage: json['resume_page'] ?? 1,
      security: ReaderSecurityPolicy.fromJson(
        json['security'] ?? {},
      ),
      canRead: json['can_read'] ?? false,
    );
  }
}
