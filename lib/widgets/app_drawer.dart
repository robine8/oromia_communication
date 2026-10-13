import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.78,
      backgroundColor: const Color(0xff171717),
      child: SafeArea(
        child: Column(
          children: [
            // Header with logo
            Container(
              height: 70,
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width: 45,
                    height: 45,
                    errorBuilder: (_, __, ___) {
                      return const Icon(
                        Icons.account_balance,
                        color: Colors.white,
                      );
                    },
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      'OROMIA COMMUNICATION BUREAU',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Divider(color: Colors.white24),

            // Menu items
            _drawerItem('ODUU', true, context),
            _drawerItem('CALBAASII', false, context),
            _drawerItem('MOOTUMMAA', true, context),
            _drawerItem('MIIDIYAA', true, context),
            _drawerItem('KALLACHA OROMIYAA', true, context),
            _drawerItem('TAJAAJILA TOORARRAA', true, context),
            _drawerItem("WAA'EE KEENYA", true, context),
            _drawerItem('AFAAN OROMOO', true, context),

            const Spacer(),

            _drawerItem('SEENI', false, context),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem(String title, bool arrow, BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 25),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: arrow
          ? const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 14,
            )
          : null,
      onTap: () {
        Navigator.pop(context);
        // Navigate to respective screen based on title
        _navigateToScreen(title, context);
      },
    );
  }

  void _navigateToScreen(String title, BuildContext context) {
    // This is where you can add navigation logic
    // For now, just show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Navigating to $title'),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
