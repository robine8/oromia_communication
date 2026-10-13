import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/publication_providers.dart';
import '../models/publication_model.dart';
import '../widgets/publication_card.dart';
import '../core/utils/app_logger.dart';

class PublicationListScreen extends ConsumerStatefulWidget {
  final String typeSlug;

  const PublicationListScreen({
    super.key,
    required this.typeSlug,
  });

  @override
  ConsumerState<PublicationListScreen> createState() =>
      _PublicationListScreenState();
}

class _PublicationListScreenState extends ConsumerState<PublicationListScreen> {
  List<Publication> _publications = [];
  bool _isLoading = true;
  String? _archiveFilter;

  final List<String> _archiveFilters = ['All', '2024', '2023', '2022'];

  @override
  void initState() {
    super.initState();
    _loadPublications();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _loadPublications() async {
    setState(() => _isLoading = true);

    try {
      final repo = ref.read(publicationRepositoryProvider);
      final type = widget.typeSlug == 'archive' &&
              _archiveFilter != null &&
              _archiveFilter != 'All'
          ? '${widget.typeSlug}/${_archiveFilter!.toLowerCase()}'
          : widget.typeSlug;

      final pubs = await repo.getPublicationsByType(type);
      setState(() {
        _publications = pubs;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      AppLogger.error('Failed to load publications', e);
    }
  }

  void _applyArchiveFilter(String filter) {
    setState(() {
      _archiveFilter = filter;
    });
    _loadPublications();
  }

  Widget _buildArchiveFilters() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: _archiveFilters.map((filter) {
          final isSelected = _archiveFilter == filter;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: FilterChip(
              label: Text(filter),
              selected: isSelected,
              onSelected: (_) => _applyArchiveFilter(filter),
              backgroundColor: Colors.grey[200],
              selectedColor: Colors.blue[100],
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Text(_getTitle()),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          if (widget.typeSlug == 'archive') _buildArchiveFilters(),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _publications.isEmpty
                    ? const Center(
                        child: Text(
                          'No publications found',
                          style: TextStyle(fontSize: 16),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _publications.length,
                        itemBuilder: (context, index) {
                          final pub = _publications[index];
                          return PublicationCard(
                            publication: pub,
                            onTap: () {
                              context.push('/kallacha/reader', extra: {
                                'publication': pub.toJson(),
                                'type': widget.typeSlug,
                              });
                            },
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }

  String _getTitle() {
    switch (widget.typeSlug) {
      case 'archive':
        return 'Archives';
      case 'bulletin':
        return 'Bulletins';
      case 'book':
        return 'Books';
      default:
        return 'Publications';
    }
  }
}
