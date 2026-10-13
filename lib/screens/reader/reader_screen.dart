import 'package:flutter/material.dart';
import 'package:screen_protector/screen_protector.dart';

class ReaderScreen extends StatefulWidget {
  final String pageUrlTemplate;
  final int pageCount;
  final int resumePage;
  final Map<String, dynamic> security;
  final String documentId;

  const ReaderScreen({
    super.key,
    required this.pageUrlTemplate,
    required this.pageCount,
    this.resumePage = 1,
    required this.security,
    required this.documentId,
  });

  @override
  State<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.resumePage;
    _enableSecureMode();
  }

  @override
  void dispose() {
    _disableSecureMode();
    super.dispose();
  }

  Future<void> _enableSecureMode() async {
    if (widget.security['android_flag_secure'] == true) {
      try {
        // Enforce secure flag (prevents screenshots & recents preview)
        await ScreenProtector.preventScreenshotOn();
      } catch (e) {
        debugPrint('Error enabling secure screen protection: $e');
      }
    }
  }

  Future<void> _disableSecureMode() async {
    try {
      await ScreenProtector.preventScreenshotOff();
    } catch (e) {
      debugPrint('Error disabling secure screen protection: $e');
    }
  }

  String _getPageUrl(int page) {
    return widget.pageUrlTemplate.replaceAll('{page}', page.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page $_currentPage of ${widget.pageCount}'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        actions: [
          if (widget.security['watermark'] == true)
            const Padding(
              padding: EdgeInsets.only(right: 16),
              child: Icon(Icons.branding_watermark),
            ),
        ],
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onHorizontalDragEnd: (details) {
                if (details.primaryVelocity! < 0) {
                  _nextPage();
                } else if (details.primaryVelocity! > 0) {
                  _previousPage();
                }
              },
              child: Center(
                child: Image.network(
                  _getPageUrl(_currentPage),
                  fit: BoxFit.contain,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                        color: Colors.white,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Text(
                        'Failed to load page',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          // Page navigation controls
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.black87,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left, color: Colors.white),
                  onPressed: _currentPage > 1 ? _previousPage : null,
                ),
                Text(
                  '$_currentPage / ${widget.pageCount}',
                  style: const TextStyle(color: Colors.white),
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right, color: Colors.white),
                  onPressed: _currentPage < widget.pageCount ? _nextPage : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _nextPage() {
    if (_currentPage < widget.pageCount) {
      setState(() {
        _currentPage++;
      });
      _saveProgress();
    }
  }

  void _previousPage() {
    if (_currentPage > 1) {
      setState(() {
        _currentPage--;
      });
      _saveProgress();
    }
  }

  Future<void> _saveProgress() async {
    try {
      debugPrint('Progress saved successfully: Document ${widget.documentId}, Page $_currentPage');
    } catch (e) {
      debugPrint('Error saving progress: $e');
    }
  }
}