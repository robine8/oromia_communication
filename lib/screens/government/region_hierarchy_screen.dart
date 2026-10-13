import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/government_provider.dart';
import '../../models/government_models.dart';

class RegionHierarchyScreen extends ConsumerStatefulWidget {
  final String rootType; // 'zone' or 'city'
  final int? parentId;
  final String? parentType;
  final String? title;
  final String? breadcrumb;

  const RegionHierarchyScreen({
    super.key,
    required this.rootType,
    this.parentId,
    this.parentType,
    this.title,
    this.breadcrumb,
  });

  @override
  ConsumerState<RegionHierarchyScreen> createState() => _RegionHierarchyScreenState();
}

class _RegionHierarchyScreenState extends ConsumerState<RegionHierarchyScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final title = widget.title ?? _getDefaultTitle();

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        actions: [
          if (widget.breadcrumb != null)
            TextButton(
              onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
              child: Text(
                'Home',
                style: TextStyle(color: Colors.white.withOpacity(0.8)),
              ),
            ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search ${_getSearchHint()}...',
                prefixIcon: const Icon(Icons.search, color: Colors.white54),
                filled: true,
                fillColor: Colors.white.withOpacity(0.15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                hintStyle: const TextStyle(color: Colors.white54),
              ),
              style: const TextStyle(color: Colors.white),
              onChanged: (value) => setState(() => _searchQuery = value.toLowerCase()),
            ),
          ),
        ),
      ),
      body: _buildBody(),
    );
  }

  String _getDefaultTitle() {
    if (widget.title != null) return widget.title!;
    if (widget.parentId != null) {
      switch (widget.parentType) {
        case 'zone':
          return 'Woredas';
        case 'woreda':
          return 'Kebeles';
        case 'city':
          return 'Sub-Cities';
        case 'sub_city':
          return 'Kebeles';
        default:
          return 'Details';
      }
    }
    return widget.rootType == 'zone' ? 'Zones' : 'Cities';
  }

  String _getSearchHint() {
    if (widget.parentId != null) {
      switch (widget.parentType) {
        case 'zone':
          return 'Woredas';
        case 'woreda':
          return 'Kebeles';
        case 'city':
          return 'Sub-Cities';
        case 'sub_city':
          return 'Kebeles';
        default:
          return 'items';
      }
    }
    return widget.rootType == 'zone' ? 'Zones' : 'Cities';
  }

  Widget _buildBody() {
    if (widget.parentId != null) {
      return _buildChildList();
    }

    // Root level - show zones or cities
    if (widget.rootType == 'zone') {
      return _buildRootList(zonesProvider, 'Zones');
    } else {
      return _buildRootList(citiesProvider, 'Cities');
    }
  }

  // Fixed: Changed ProviderListenable<AsyncValue<List<GovRegion>>> to dynamic
  // because ProviderListenable is not recognized in some Riverpod versions
  Widget _buildRootList(
    dynamic provider,
    String type,
  ) {
    final asyncData = ref.watch(provider);

    return asyncData.when(
      data: (items) => _buildItemsList(items, type),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }

  Widget _buildChildList() {
    final parentId = widget.parentId!;
    final parentType = widget.parentType!;

    dynamic provider;
    late String type;

    if (parentType == 'zone') {
      provider = woredasProvider(parentId);
      type = 'Woredas';
    } else if (parentType == 'woreda') {
      provider = kebelesProvider({'parentId': parentId, 'parentType': 'woreda'});
      type = 'Kebeles';
    } else if (parentType == 'city') {
      provider = subCitiesProvider(parentId);
      type = 'Sub-Cities';
    } else if (parentType == 'sub_city') {
      provider = kebelesProvider({'parentId': parentId, 'parentType': 'sub_city'});
      type = 'Kebeles';
    } else {
      return const Center(child: Text('Invalid hierarchy'));
    }

    final asyncData = ref.watch(provider);

    return asyncData.when(
      data: (items) => _buildItemsList(items, type),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }

  Widget _buildItemsList(List<GovRegion> items, String type) {
    final filtered = items
        .where((item) => item.name.toLowerCase().contains(_searchQuery))
        .toList();

    if (filtered.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              'No $type found',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try a different search term',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final item = filtered[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: ListTile(
            title: Text(
              item.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: item.isLeaf
                ? (item.contactInfo != null
                    ? Text(item.contactInfo!, style: const TextStyle(fontSize: 12))
                    : null)
                : Text(
                    '${item.childCount} ${item.childTypeDisplayName}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
            trailing: item.isLeaf
                ? const Icon(Icons.info_outline, color: Colors.grey)
                : const Icon(Icons.chevron_right),
            onTap: () {
              if (item.isLeaf) {
                _showKebeleDetail(context, item);
              } else {
                _navigateToNextLevel(item);
              }
            },
          ),
        );
      },
    );
  }

  void _navigateToNextLevel(GovRegion item) {
    String title;

    switch (item.type) {
      case 'zone':
        title = '${item.name} Woredas';
        break;
      case 'woreda':
        title = '${item.name} Kebeles';
        break;
      case 'city':
        title = '${item.name} Sub-Cities';
        break;
      case 'sub_city':
        title = '${item.name} Kebeles';
        break;
      default:
        return;
    }

    final newBreadcrumb = widget.breadcrumb != null
        ? '${widget.breadcrumb} > ${item.name}'
        : item.name;

    context.push(
      '/government/hierarchy/${item.type}/${item.id}',
      extra: {
        'parentType': item.type,
        'parentId': item.id,
        'title': title,
        'breadcrumb': newBreadcrumb,
      },
    );
  }

  void _showKebeleDetail(BuildContext context, GovRegion kebele) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(kebele.name),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.breadcrumb != null) ...[
              Text(
                'Path: ${widget.breadcrumb} > ${kebele.name}',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 8),
            ],
            const Text(
              'Administrative Level: Kebele',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            if (kebele.contactInfo != null) ...[
              const SizedBox(height: 8),
              Text('Contact: ${kebele.contactInfo}'),
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
}