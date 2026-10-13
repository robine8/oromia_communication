import 'dart:io';
import 'package:flutter/services.dart';
import '../core/utils/app_logger.dart';

class SecureViewerService {
  bool _isSecureMode = false;

  Future<void> enableSecureMode() async {
    try {
      if (Platform.isAndroid) {
        await SystemChrome.setEnabledSystemUIMode(
          SystemUiMode.manual,
          overlays: SystemUiOverlay.values,
        );
        _isSecureMode = true;
      }
      AppLogger.info('Secure mode enabled');
    } catch (e) {
      AppLogger.error('Failed to enable secure mode', e);
    }
  }

  Future<void> disableSecureMode() async {
    try {
      if (Platform.isAndroid) {
        await SystemChrome.setEnabledSystemUIMode(
          SystemUiMode.manual,
          overlays: SystemUiOverlay.values,
        );
        _isSecureMode = false;
      }
      AppLogger.info('Secure mode disabled');
    } catch (e) {
      AppLogger.error('Failed to disable secure mode', e);
    }
  }

  bool get isSecureMode => _isSecureMode;
}
