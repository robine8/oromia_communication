// lib/screens/news/news_list_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NewsListScreen extends StatefulWidget {
  final String categorySlug;
  const NewsListScreen({super.key, required this.categorySlug});

  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  String _filter = 'Most Recent';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.categorySlug.toUpperCase()} News')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: DropdownButtonFormField<String>(
              initialValue: _filter,
              decoration: const InputDecoration(
                labelText: 'Very Much Read',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'Most Read', child: Text('Most Read')),
                DropdownMenuItem(value: 'Most Recent', child: Text('Most Recent')),
                DropdownMenuItem(value: 'Editor\'s Pick', child: Text('Editor\'s Pick')),
              ],
              onChanged: (v) => setState(() => _filter = v!),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Card(
                    child: InkWell(
                      onTap: () => context.push('/news/all/${index + 1}'),
                      child: Row(
                        children: [
                          Container(
                            width: 120,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
                              image: DecorationImage(
                                image: NetworkImage('https://picsum.photos/seed/news${index + 1}/200/150'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'News Title',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: const [
                                      Icon(Icons.access_time, size: 12, color: Colors.grey),
                                      SizedBox(width: 4),
                                      Text('Dec 13, 2024', style: TextStyle(fontSize: 10, color: Colors.grey)),
                                      Spacer(),
                                      Icon(Icons.visibility, size: 12, color: Colors.grey),
                                      SizedBox(width: 2),
                                      Text('104', style: TextStyle(fontSize: 10, color: Colors.grey)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}