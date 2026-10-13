import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import '../../models/media_type.dart';
import '../../models/media_item.dart';
import '../../providers/media_provider.dart';

class MediaListScreen extends ConsumerStatefulWidget {
  final String typeSlug;

  const MediaListScreen({super.key, required this.typeSlug});

  @override
  ConsumerState<MediaListScreen> createState() => _MediaListScreenState();
}

class _MediaListScreenState extends ConsumerState<MediaListScreen> {
  final ScrollController _scrollController = ScrollController();
  List<MediaItem> _items = [];
  int _page = 1;
  bool _isLoading = false;
  bool _hasMore = true;

  MediaType get _mediaType {
    return MediaType.values.firstWhere(
      (t) => t.apiTypeSlug == widget.typeSlug,
      orElse: () => MediaType.pressRelease,
    );
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadItems();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _loadItems();
    }
  }

  Future<void> _loadItems() async {
    if (_isLoading || !_hasMore) return;
    setState(() => _isLoading = true);

    try {
      final repo = ref.read(mediaRepositoryProvider);
      final newItems = await repo.list(type: widget.typeSlug, page: _page);

      setState(() {
        if (_page == 1) {
          _items = newItems;
        } else {
          _items.addAll(newItems);
        }
        _page++;
        _hasMore = newItems.length >= 20;
      });
    } catch (e) {
      print('Error loading media: $e');
    }

    setState(() => _isLoading = false);
  }

  Future<void> _refresh() async {
    setState(() {
      _page = 1;
      _hasMore = true;
    });
    await _loadItems();
  }

  @override
  Widget build(BuildContext context) {
    final type = _mediaType;

    return Scaffold(
      appBar: AppBar(
        title: Text(type.displayName),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  type.displayName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1a3a6b),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  type.subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          // Content
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refresh,
              child: _items.isEmpty && !_isLoading
                  ? _buildEmptyState(type)
                  : _buildContent(type),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(MediaType type) {
    switch (type) {
      case MediaType.pressRelease:
        return _buildPressReleaseList();
      case MediaType.documentary:
      case MediaType.video:
        return _buildVideoGrid();
      case MediaType.imageGallery:
        return _buildGalleryGrid();
      case MediaType.audioFiles:
        return _buildAudioList();
    }
  }

  Widget _buildPressReleaseList() {
    return ListView.builder(
      controller: _scrollController,
      itemCount: _items.length + (_hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == _items.length) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(),
            ),
          );
        }
        final item = _items[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: ListTile(
            leading: const Icon(Icons.description, color: Color(0xFF1a3a6b)),
            title: Text(
              item.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              DateFormat('MMM d, yyyy').format(item.publishedAt ?? DateTime.now()),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => _showPressReleaseDetail(item),
          ),
        );
      },
    );
  }

  Widget _buildVideoGrid() {
    return GridView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: _items.length + (_hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == _items.length) {
          return const Center(child: CircularProgressIndicator());
        }
        final item = _items[index];
        return _buildVideoCard(item);
      },
    );
  }

  Widget _buildVideoCard(MediaItem item) {
    return GestureDetector(
      onTap: () {
        if (item.mediaUrl != null) {
          context.push('/media/player', extra: {
            'title': item.title,
            'url': item.mediaUrl,
          });
        }
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail with overlay
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Thumbnail
                  Image.network(
                    item.thumbnailUrl ?? 'https://picsum.photos/400/300',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey.shade300,
                        child: Icon(Icons.image, color: Colors.grey.shade500),
                      );
                    },
                  ),
                  // Dark overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.3),
                          Colors.black.withOpacity(0.6),
                        ],
                      ),
                    ),
                  ),
                  // Play button
                  const Center(
                    child: Icon(
                      Icons.play_circle_filled,
                      color: Colors.white,
                      size: 48,
                    ),
                  ),
                  // Title at bottom
                  Positioned(
                    bottom: 8,
                    left: 8,
                    right: 8,
                    child: Text(
                      item.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            // Caption below
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 12, color: Color(0xFFc0392b)),
                      const SizedBox(width: 4),
                      Text(
                        DateFormat('MMM d, yyyy').format(item.publishedAt ?? DateTime.now()),
                        style: const TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Container(
                    height: 2,
                    color: const Color(0xFFc0392b),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGalleryGrid() {
    return GridView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
        childAspectRatio: 1,
      ),
      itemCount: _items.length + (_hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == _items.length) {
          return const Center(child: CircularProgressIndicator());
        }
        final item = _items[index];
        return GestureDetector(
          onTap: () {
            if (item.imageUrls != null && item.imageUrls!.isNotEmpty) {
              context.push('/media/gallery', extra: {
                'title': item.title,
                'images': item.imageUrls,
              });
            }
          },
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  item.thumbnailUrl ?? 'https://picsum.photos/400/400',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(color: Colors.grey.shade300);
                  },
                ),
                if (item.imageUrls != null && item.imageUrls!.length > 1)
                  Positioned(
                    top: 4,
                    right: 4,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${item.imageUrls!.length}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAudioList() {
    return ListView.builder(
      controller: _scrollController,
      itemCount: _items.length + (_hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == _items.length) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(),
            ),
          );
        }
        final item = _items[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: ListTile(
            leading: const Icon(Icons.audiotrack, color: Color(0xFF1a3a6b)),
            title: Text(
              item.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat('MMM d, yyyy').format(item.publishedAt ?? DateTime.now()),
                  style: const TextStyle(fontSize: 12),
                ),
                if (item.duration != null)
                  Text(
                    'Duration: ${Duration(seconds: item.duration!).toString().split('.').first}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.play_circle_filled, color: Color(0xFFc0392b)),
              onPressed: () {
                // TODO: Implement audio playback with just_audio
                print('Playing: ${item.title}');
              },
            ),
          ),
        );
      },
    );
  }

  void _showPressReleaseDetail(MediaItem item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(item.title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat('MMM d, yyyy').format(item.publishedAt ?? DateTime.now()),
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const SizedBox(height: 12),
            Text(item.description ?? 'No content available'),
            if (item.fileUrl != null) ...[
              const SizedBox(height: 12),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Open PDF or document
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFc0392b),
                  ),
                  child: const Text('View Full Document'),
                ),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(MediaType type) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            type.icon,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'No ${type.displayName} Available',
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