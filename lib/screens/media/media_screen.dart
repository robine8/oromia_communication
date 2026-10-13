// screens/media/media_screen.dart
import 'package:flutter/material.dart';

class MediaScreen extends StatefulWidget {
  const MediaScreen({super.key});

  @override
  State<MediaScreen> createState() => _MediaScreenState();
}

class _MediaScreenState extends State<MediaScreen> with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Media'),
        bottom: TabBar(
          controller: _controller,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Press Release'),
            Tab(text: 'Documentary'),
            Tab(text: 'Video'),
            Tab(text: 'Gallery'),
            Tab(text: 'Audio'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          _buildPressRelease(),
          _buildGrid(),
          _buildGrid(),
          _buildGallery(),
          _buildAudio(),
        ],
      ),
    );
  }

  Widget _buildPressRelease() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.all(8),
          child: ListTile(
            title: Text('Press Release ${index + 1}'),
            subtitle: Text('December ${10 + index}, 2024'),
            trailing: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFc0392b)),
              child: const Text('View'),
            ),
          ),
        );
      },
    );
  }

  Widget _buildGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.8,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Card(
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                        image: DecorationImage(
                          image: NetworkImage('https://picsum.photos/seed/doc${index + 1}/400/300'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const Center(child: Icon(Icons.play_circle_filled, color: Colors.white, size: 48)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text('Title ${index + 1}', style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildGallery() {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      itemCount: 12,
      itemBuilder: (context, index) {
        return Card(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage('https://picsum.photos/seed/gallery${index + 1}/200/200'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAudio() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.all(8),
          child: ListTile(
            leading: const Icon(Icons.audiotrack, color: Color(0xFF1a3a6b)),
            title: Text('Audio ${index + 1}'),
            subtitle: Text('Duration: ${3 + index}:${30 + index * 5}'),
            trailing: IconButton(
              icon: const Icon(Icons.play_circle_filled),
              onPressed: () {},
            ),
          ),
        );
      },
    );
  }
}
