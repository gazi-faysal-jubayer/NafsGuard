import 'dart:io';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';

class OverlayService {
  static Future<bool> requestPermission() async {
    if (!Platform.isAndroid) return true;
    final granted = await FlutterOverlayWindow.isPermissionGranted();
    if (granted) return true;
    await FlutterOverlayWindow.requestPermission();
    return FlutterOverlayWindow.isPermissionGranted();
  }

  static Future<bool> hasPermission() async {
    if (!Platform.isAndroid) return true;
    return FlutterOverlayWindow.isPermissionGranted();
  }

  static Future<void> showBlockade() async {
    if (!Platform.isAndroid) return;

    final granted = await FlutterOverlayWindow.isPermissionGranted();
    if (!granted) return;

    await FlutterOverlayWindow.showOverlay(
      height: WindowSize.matchParent,
      width: WindowSize.matchParent,
      alignment: OverlayAlignment.center,
      flag: OverlayFlag.defaultFlag,
      enableDrag: false,
    );
  }

  static Future<void> dismissBlockade() async {
    if (!Platform.isAndroid) return;

    final isActive = await FlutterOverlayWindow.isActive();
    if (isActive) {
      await FlutterOverlayWindow.closeOverlay();
    }
  }
}
