import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

class DeviceId {
  static Future<String> getDeviceId() async {
    final deviceInfo = DeviceInfoPlus();
    if (kIsWeb) {
      return 'web_device';
    }
    try {
      final androidInfo = await deviceInfo.androidInfo;
      return androidInfo.id ?? 'android_device';
    } catch (e) {
      try {
        final iosInfo = await deviceInfo.iosInfo;
        return iosInfo.identifierForVendor ?? 'ios_device';
      } catch (e) {
        return 'unknown_device';
      }
    }
  }
}
