import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  final String title;

  const CategoryScreen({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2477B9),
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _getIcon(title),
              size: 70,
              color: const Color(0xFF2477B9),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2477B9),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Content will be loaded here.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD90000),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 35,
                  vertical: 14,
                ),
              ),
              child: const Text('BACK'),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIcon(String title) {
    switch (title) {
      case 'Oduu':
        return Icons.article;

      case 'Calbaasii':
        return Icons.campaign;

      case 'Mootummaa':
        return Icons.account_balance;

      case 'Miidiyaa':
        return Icons.video_library;

      case 'Kallacha Oromiyaa':
        return Icons.menu_book;

      case 'Tajaajila Toorarraa':
        return Icons.miscellaneous_services;

      case "Waa'ee Keenya":
        return Icons.info;

      case 'Afaan Oromoo':
        return Icons.language;

      default:
        return Icons.menu;
    }
  }
}
