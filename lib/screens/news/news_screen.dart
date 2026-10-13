import 'package:flutter/material.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1D1D1D),
      appBar: AppBar(
        title: const Text('News', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF06206B),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildNewsCard(
            context,
            'Birraafi Oromoo!',
            'Oduu haaraa Biiroo Kominikeeshinii Oromiyaa',
            'HAGAYYA 27, 2018',
            '12',
          ),
          _buildNewsCard(
            context,
            'Tarsiimoon Barnootaa Bocamee Hojirra Oolaa Jiru Jijjiirama Bu\'uuraa Fidaa Jira.',
            'Oduu Tibbanaa Dinagdee Keenya',
            'HAGAYYA 26, 2018',
            '29',
          ),
          _buildNewsCard(
            context,
            'Goobeefi Shinooyyee: Faana Ifa Birraa, Calaqqee Nagaafi Bareedina Aadaa Oromoo',
            'Oduu Tibbanaa Hawaasummaa Keenya',
            'HAGAYYA 25, 2018',
            '480',
          ),
          _buildNewsCard(
            context,
            'Imalli Dijitaala Itoophiyaa Guddina Damee Dijitaalaa',
            'Oduu Teeknoolojii',
            'BITOOTESSA 17, 2018',
            '672',
          ),
          _buildNewsCard(
            context,
            'Dorgommiin Ispoortii Aadaa Tokkummaa Hawaasaa Cimsuuf',
            'Oduu Ispoortii',
            'BITOOTESSA 29, 2018',
            '587',
          ),
        ],
      ),
    );
  }

  Widget _buildNewsCard(
    BuildContext context,
    String title,
    String subtitle,
    String date,
    String views,
  ) {
    return Card(
      color: const Color(0xFF292929),
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          color: const Color(0xFFC90000),
          child: const Icon(Icons.newspaper, color: Colors.white),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              subtitle,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.access_time, color: Colors.white38, size: 12),
                const SizedBox(width: 4),
                Text(
                  date,
                  style: const TextStyle(color: Colors.white38, fontSize: 10),
                ),
                const SizedBox(width: 12),
                const Icon(
                  Icons.remove_red_eye,
                  color: Colors.white38,
                  size: 12,
                ),
                const SizedBox(width: 4),
                Text(
                  views,
                  style: const TextStyle(color: Colors.white38, fontSize: 10),
                ),
              ],
            ),
          ],
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.white54,
          size: 16,
        ),
        onTap: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Opening: $title')));
        },
      ),
    );
  }
}
