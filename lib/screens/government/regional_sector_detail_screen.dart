import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/regional_sector_model.dart';

class RegionalSectorDetailScreen extends StatelessWidget {
  final RegionalSector sector;

  const RegionalSectorDetailScreen({
    super.key,
    required this.sector,
  });

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      }
    } catch (e) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Text(sector.name),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (sector.imageUrl != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  sector.imageUrl!,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 200,
                    color: Colors.grey[300],
                    child: const Icon(Icons.broken_image, size: 50),
                  ),
                ),
              ),
            const SizedBox(height: 16),
            Text(
              sector.description,
              style: const TextStyle(fontSize: 16, height: 1.6),
            ),
            const SizedBox(height: 24),
            if (sector.contacts != null && sector.contacts!.isNotEmpty) ...[
              const Text(
                'Contacts',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              ...sector.contacts!.map((contact) => Card(
                    child: ListTile(
                      leading: Icon(
                        contact.type == 'phone' ? Icons.phone : Icons.email,
                      ),
                      title: Text(contact.value),
                      subtitle: Text(contact.label ?? ''),
                      onTap: () => _launchUrl(
                        contact.type == 'phone'
                            ? 'tel:${contact.value}'
                            : 'mailto:${contact.value}',
                      ),
                    ),
                  )),
            ],
            if (sector.website != null) ...[
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () => _launchUrl(sector.website!),
                icon: const Icon(Icons.public),
                label: const Text('Visit Website'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
