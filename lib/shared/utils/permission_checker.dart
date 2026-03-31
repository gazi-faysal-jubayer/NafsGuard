import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import '../../core/services/overlay_service.dart';

class PermissionChecker {
  static Future<Map<String, bool>> checkAll() async {
    final results = <String, bool>{};

    // Notification permission
    final notifStatus = await Permission.notification.status;
    results['notifications'] = notifStatus.isGranted;

    // Overlay permission (Android only)
    if (Platform.isAndroid) {
      results['overlay'] = await OverlayService.hasPermission();
    } else {
      results['overlay'] = true;
    }

    // Usage stats (Android only, needs manual check via app settings)
    if (Platform.isAndroid) {
      results['usageStats'] = true; // Must be checked via UsageStats API
    } else {
      results['usageStats'] = true;
    }

    return results;
  }

  static Future<bool> allGranted() async {
    final results = await checkAll();
    return results.values.every((v) => v);
  }
}
