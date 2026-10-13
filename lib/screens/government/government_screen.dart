// screens/government/government_screen.dart
import 'package:flutter/material.dart';

class GovernmentScreen extends StatelessWidget {
  const GovernmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Government Structure')),
      body: ListView.builder(
        itemCount: 6,
        itemBuilder: (context, index) {
          const names = ['Regional Sectors', 'Zone', 'Woreda', 'City', 'Sub-city', 'Kebele'];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(names[index]),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const _DetailScreen()),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _DetailScreen extends StatelessWidget {
  const _DetailScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Details')),
      body: ListView.builder(
        itemCount: 8,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text('Item ${index + 1}'),
              subtitle: Text('Contact: info@item${index + 1}.gov.et'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const _DetailScreen()),
              ),
            ),
          );
        },
      ),
    );
  }
}
