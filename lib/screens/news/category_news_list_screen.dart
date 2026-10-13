import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../models/news.dart';
import '../../models/news_category.dart';
import '../../widgets/news_list_card.dart';
import '../../widgets/sort_dropdown.dart';

// Helper repository class to satisfy provider requirements locally
class NewsRepository {
  Future<Map<String, dynamic>> list({
    String? category,
    int page = 1,
    int limit = 20,
  }) async {
    // Returns empty success response; integrate backend API here as needed
    return {
      'success': true,
      'data': <Map<String, dynamic>>[],
    };
  }
}

final newsRepositoryProvider = Provider<NewsRepository>((ref) {
  return NewsRepository();
});

class CategoryNewsListScreen extends ConsumerStatefulWidget {
  final NewsCategory category;

  const CategoryNewsListScreen({
    super.key,
    required this.category,
  });

  @override
  ConsumerState<CategoryNewsListScreen> createState() => _CategoryNewsListScreenState();
}

class _CategoryNewsListScreenState extends ConsumerState<CategoryNewsListScreen> {
  final ScrollController _scrollController = ScrollController();
  List<News> _news = [];
  int _page = 1;
  bool _isLoading = false;
  bool _hasMore = true;
  String _currentSort = 'most_recent';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadNews();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _loadNews();
    }
  }

  Future<void> _loadNews() async {
    if (_isLoading || !_hasMore) return;

    setState(() => _isLoading = true);

    try {
      final repo = ref.read(newsRepositoryProvider);
      final response = await repo.list(
        category: widget.category.slug == 'all' ? null : widget.category.slug,
        page: _page,
        limit: 20,
      );

      if (response['success'] == true) {
        final data = response['data'];
        if (data is List) {
          final newNews = data.map((item) => News.fromJson(item)).toList();

          // Apply client-side sorting
          final sorted = _applySort(newNews, _currentSort);

          setState(() {
            if (_page == 1) {
              _news = sorted;
            } else {
              _news.addAll(sorted);
            }
            _page++;
            _hasMore = data.length >= 20;
          });
        }
      }
    } catch (e) {
      debugPrint('Error loading news: $e');
      setState(() {
        _news = [];
        _hasMore = false;
      });
    }

    setState(() => _isLoading = false);
  }

  List<News> _applySort(List<News> items, String sort) {
    // Switch to server-side sort param once backend confirms
    switch (sort) {
      case 'most_read':
        return List.from(items)..sort((a, b) => b.viewCount.compareTo(a.viewCount));
      case 'most_recent':
        return List.from(items)..sort((a, b) {
          if (a.publishedAt == null) return 1;
          if (b.publishedAt == null) return -1;
          return b.publishedAt!.compareTo(a.publishedAt!);
        });
      default:
        return items;
    }
  }

  Future<void> _refresh() async {
    setState(() {
      _page = 1;
      _hasMore = true;
    });
    await _loadNews();
  }

  void _onSortChanged(String value) {
    setState(() {
      _currentSort = value;
      _news = _applySort(_news, value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.displayName),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          // Sort Dropdown
          SortDropdown(
            label: 'Very Much Read',
            initialValue: _currentSort,
            onChanged: _onSortChanged,
          ),
          // News List
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refresh,
              child: _news.isEmpty && !_isLoading
                  ? _buildEmptyState()
                  : ListView.builder(
                      controller: _scrollController,
                      itemCount: _news.length + (_hasMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == _news.length) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        final news = _news[index];
                        return NewsListCard(
                          news: news,
                          onTap: () => context.push(
                            '/news/${news.categorySlug}/${news.id}',
                          ),
                          compact: true,
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.newspaper_outlined,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'No news found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Check back later for updates',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }
}