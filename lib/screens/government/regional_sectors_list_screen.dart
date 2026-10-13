import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/government_provider.dart';
import 'regional_sector_detail_screen.dart';

class RegionalSectorsListScreen extends ConsumerStatefulWidget {
  const RegionalSectorsListScreen({super.key});

  @override
  ConsumerState<RegionalSectorsListScreen> createState() => _RegionalSectorsListScreenState();
}

class _RegionalSectorsListScreenState extends ConsumerState<RegionalSectorsListScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final sectorsAsync = ref.watch(regionalSectorsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Regional Sectors'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search sectors...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (value) => setState(() => _searchQuery = value.toLowerCase()),
            ),
          ),
          Expanded(
            child: sectorsAsync.when(
              data: (sectors) {
                final filtered = sectors.where((s) =>
                  s.name.toLowerCase().contains(_searchQuery) ||
                  s.description.toLowerCase().contains(_searchQuery)
                ).toList();

                if (filtered.isEmpty) {
                  return const Center(
                    child: Text('No sectors found'),
                  );
                }

                return ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final sector = filtered[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      child: ListTile(
                        title: Text(
                          sector.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              sector.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                if (sector.contactPhone != null) ...[
                                  const Icon(Icons.phone, size: 14, color: Colors.grey),
                                  const SizedBox(width: 4),
                                  Text(
                                    sector.contactPhone!,
                                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                                  ),
                                ],
                                if (sector.contactEmail != null) ...[
                                  const SizedBox(width: 12),
                                  const Icon(Icons.email, size: 14, color: Colors.grey),
                                  const SizedBox(width: 4),
                                  Text(
                                    sector.contactEmail!,
                                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegionalSectorDetailScreen(sector: sector),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
          ),
        ],
      ),
    );
  }
}