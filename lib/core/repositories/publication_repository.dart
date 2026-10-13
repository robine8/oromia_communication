import '../../models/publication_item.dart';

class PublicationRepository {
  // TODO: Replace with real API call once backend confirms
  // Uses the same read/catalog endpoint as the ReaderRepository

  Future<List<PublicationItem>> catalog({
    required String type,
    int page = 1,
    int limit = 20,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Return mock data based on type
    return _getMockPublications(type);
  }

  List<PublicationItem> _getMockPublications(String type) {
    switch (type) {
      case 'weekly':
        return _getWeeklyPublications();
      case 'monthly':
        return _getQuarterlyPublications();
      case 'yearly':
        return _getYearlyPublications();
      case 'brochure':
        return _getBrochurePublications();
      case 'archive':
        return _getArchivePublications();
      case 'file':
        return _getFilesAndBooksPublications();
      default:
        return [];
    }
  }

  List<PublicationItem> _getWeeklyPublications() {
    return [
      PublicationItem(
        id: 1,
        title: 'Kallacha Weekly - August 2026',
        subtitle: 'Week 34 Issue',
        coverImage: 'https://picsum.photos/seed/kw1/400/500',
        type: 'weekly',
        publishedAt: DateTime.now().subtract(const Duration(days: 3)),
        pageCount: 24,
        issueNumber: 34,
      ),
      PublicationItem(
        id: 2,
        title: 'Kallacha Weekly - August 2026',
        subtitle: 'Week 33 Issue',
        coverImage: 'https://picsum.photos/seed/kw2/400/500',
        type: 'weekly',
        publishedAt: DateTime.now().subtract(const Duration(days: 10)),
        pageCount: 22,
        issueNumber: 33,
      ),
      PublicationItem(
        id: 3,
        title: 'Kallacha Weekly - August 2026',
        subtitle: 'Week 32 Issue',
        coverImage: 'https://picsum.photos/seed/kw3/400/500',
        type: 'weekly',
        publishedAt: DateTime.now().subtract(const Duration(days: 17)),
        pageCount: 20,
        issueNumber: 32,
      ),
      PublicationItem(
        id: 4,
        title: 'Kallacha Weekly - July 2026',
        subtitle: 'Week 31 Issue',
        coverImage: 'https://picsum.photos/seed/kw4/400/500',
        type: 'weekly',
        publishedAt: DateTime.now().subtract(const Duration(days: 24)),
        pageCount: 24,
        issueNumber: 31,
      ),
      PublicationItem(
        id: 5,
        title: 'Kallacha Weekly - July 2026',
        subtitle: 'Week 30 Issue',
        coverImage: 'https://picsum.photos/seed/kw5/400/500',
        type: 'weekly',
        publishedAt: DateTime.now().subtract(const Duration(days: 31)),
        pageCount: 20,
        issueNumber: 30,
      ),
    ];
  }

  List<PublicationItem> _getQuarterlyPublications() {
    return [
      PublicationItem(
        id: 1,
        title: 'Kallacha Quarterly - Q3 2026',
        subtitle: 'July-September Issue',
        coverImage: 'https://picsum.photos/seed/kq1/400/500',
        type: 'monthly',
        publishedAt: DateTime.now().subtract(const Duration(days: 15)),
        pageCount: 48,
        issueNumber: 3,
      ),
      PublicationItem(
        id: 2,
        title: 'Kallacha Quarterly - Q2 2026',
        subtitle: 'April-June Issue',
        coverImage: 'https://picsum.photos/seed/kq2/400/500',
        type: 'monthly',
        publishedAt: DateTime.now().subtract(const Duration(days: 105)),
        pageCount: 52,
        issueNumber: 2,
      ),
      PublicationItem(
        id: 3,
        title: 'Kallacha Quarterly - Q1 2026',
        subtitle: 'January-March Issue',
        coverImage: 'https://picsum.photos/seed/kq3/400/500',
        type: 'monthly',
        publishedAt: DateTime.now().subtract(const Duration(days: 195)),
        pageCount: 44,
        issueNumber: 1,
      ),
    ];
  }

  List<PublicationItem> _getYearlyPublications() {
    return [
      PublicationItem(
        id: 1,
        title: 'Kallacha Yearly Book - 2025',
        subtitle: 'Annual Compilation',
        coverImage: 'https://picsum.photos/seed/ky1/400/500',
        type: 'yearly',
        publishedAt: DateTime(2025, 12, 31),
        pageCount: 120,
        issueNumber: 5,
      ),
      PublicationItem(
        id: 2,
        title: 'Kallacha Yearly Book - 2024',
        subtitle: 'Annual Compilation',
        coverImage: 'https://picsum.photos/seed/ky2/400/500',
        type: 'yearly',
        publishedAt: DateTime(2024, 12, 31),
        pageCount: 115,
        issueNumber: 4,
      ),
      PublicationItem(
        id: 3,
        title: 'Kallacha Yearly Book - 2023',
        subtitle: 'Annual Compilation',
        coverImage: 'https://picsum.photos/seed/ky3/400/500',
        type: 'yearly',
        publishedAt: DateTime(2023, 12, 31),
        pageCount: 108,
        issueNumber: 3,
      ),
    ];
  }

  List<PublicationItem> _getBrochurePublications() {
    return [
      PublicationItem(
        id: 1,
        title: 'Oromia Tourism Brochure',
        subtitle: 'Explore Oromia',
        coverImage: 'https://picsum.photos/seed/b1/400/500',
        type: 'brochure',
        publishedAt: DateTime.now().subtract(const Duration(days: 20)),
        pageCount: 16,
        description: 'A comprehensive guide to tourism in Oromia region.',
      ),
      PublicationItem(
        id: 2,
        title: 'Investment Opportunities Brochure',
        subtitle: 'Invest in Oromia',
        coverImage: 'https://picsum.photos/seed/b2/400/500',
        type: 'brochure',
        publishedAt: DateTime.now().subtract(const Duration(days: 45)),
        pageCount: 12,
        description: 'Investment opportunities in Oromia region.',
      ),
      PublicationItem(
        id: 3,
        title: 'Cultural Heritage Brochure',
        subtitle: 'Oromo Culture',
        coverImage: 'https://picsum.photos/seed/b3/400/500',
        type: 'brochure',
        publishedAt: DateTime.now().subtract(const Duration(days: 70)),
        pageCount: 20,
        description: 'Cultural heritage and traditions of Oromia.',
      ),
    ];
  }

  List<PublicationItem> _getArchivePublications() {
    // Combined list from all types for archive view
    return [
      ..._getWeeklyPublications().map((p) => PublicationItem(
            id: p.id + 100,
            title: p.title,
            subtitle: p.subtitle,
            coverImage: p.coverImage,
            type: 'archive',
            publishedAt: p.publishedAt,
            pageCount: p.pageCount,
            issueNumber: p.issueNumber,
          )),
      ..._getQuarterlyPublications().map((p) => PublicationItem(
            id: p.id + 200,
            title: p.title,
            subtitle: p.subtitle,
            coverImage: p.coverImage,
            type: 'archive',
            publishedAt: p.publishedAt,
            pageCount: p.pageCount,
            issueNumber: p.issueNumber,
          )),
      ..._getYearlyPublications().map((p) => PublicationItem(
            id: p.id + 300,
            title: p.title,
            subtitle: p.subtitle,
            coverImage: p.coverImage,
            type: 'archive',
            publishedAt: p.publishedAt,
            pageCount: p.pageCount,
            issueNumber: p.issueNumber,
          )),
    ];
  }

  List<PublicationItem> _getFilesAndBooksPublications() {
    return [
      PublicationItem(
        id: 1,
        title: 'Oromo Language Learning Book',
        subtitle: 'Volume 1',
        coverImage: 'https://picsum.photos/seed/f1/400/500',
        type: 'file',
        publishedAt: DateTime.now().subtract(const Duration(days: 30)),
        pageCount: 80,
        description: 'Learning the Oromo language.',
      ),
      PublicationItem(
        id: 2,
        title: 'Oromo Poetry Collection',
        subtitle: 'Traditional Poems',
        coverImage: 'https://picsum.photos/seed/f2/400/500',
        type: 'file',
        publishedAt: DateTime.now().subtract(const Duration(days: 60)),
        pageCount: 60,
        description: 'Collection of traditional Oromo poetry.',
      ),
      PublicationItem(
        id: 3,
        title: 'Oromo History Book',
        subtitle: 'A Brief History',
        coverImage: 'https://picsum.photos/seed/f3/400/500',
        type: 'file',
        publishedAt: DateTime.now().subtract(const Duration(days: 90)),
        pageCount: 100,
        description: 'A brief history of the Oromo people.',
      ),
      PublicationItem(
        id: 4,
        title: 'Oromo Cultural Guide',
        subtitle: 'Traditions & Customs',
        coverImage: 'https://picsum.photos/seed/f4/400/500',
        type: 'file',
        publishedAt: DateTime.now().subtract(const Duration(days: 120)),
        pageCount: 45,
        description: 'Oromo traditions and customs guide.',
      ),
    ];
  }
}