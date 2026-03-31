import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/text_styles.dart';
import '../../core/services/notification_service.dart';
import '../../core/services/overlay_service.dart';
import '../../shared/widgets/primary_button.dart';

class PermissionsPage extends StatefulWidget {
  final VoidCallback onAllGranted;

  const PermissionsPage({super.key, required this.onAllGranted});

  @override
  State<PermissionsPage> createState() => _PermissionsPageState();
}

class _PermissionsPageState extends State<PermissionsPage> {
  bool _usageGranted = false;
  bool _overlayGranted = false;
  bool _notificationGranted = false;

  bool get _allGranted =>
      _usageGranted && _overlayGranted && _notificationGranted;

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    if (Platform.isAndroid) {
      final overlay = await OverlayService.hasPermission();
      setState(() {
        _overlayGranted = overlay;
      });
    } else {
      setState(() {
        _usageGranted = true;
        _overlayGranted = true;
      });
    }
  }

  Future<void> _requestUsageAccess() async {
    if (Platform.isAndroid) {
      await openAppSettings();
      await Future.delayed(const Duration(seconds: 2));
      setState(() => _usageGranted = true);
    } else {
      setState(() => _usageGranted = true);
    }
  }

  Future<void> _requestOverlay() async {
    final granted = await OverlayService.requestPermission();
    setState(() => _overlayGranted = granted);
    if (!granted && mounted) {
      _showPermissionDialog('Draw Over Apps');
    }
  }

  Future<void> _requestNotifications() async {
    final granted = await NotificationService().requestPermission();
    setState(() => _notificationGranted = granted);
    if (!granted && mounted) {
      _showPermissionDialog('Notifications');
    }
  }

  void _showPermissionDialog(String permissionName) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: NafsColors.cardSurface,
        title: Text(
          '$permissionName Required',
          style: NafsTextStyles.headlineMedium,
        ),
        content: Text(
          'NafsGuard needs this permission to protect your time. '
          'Please grant it in Settings.',
          style: NafsTextStyles.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              openAppSettings();
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Set Up Permissions',
            style: NafsTextStyles.displayMedium,
            textAlign: TextAlign.center,
          )
              .animate()
              .fadeIn()
              .slideY(begin: 0.2, end: 0),
          const SizedBox(height: 8),
          Text(
            'NafsGuard needs three permissions\nto protect your time.',
            style: NafsTextStyles.bodyLarge.copyWith(
              color: NafsColors.ashMuted,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          _PermissionTile(
            icon: Icons.access_time_rounded,
            title: 'Usage Access',
            description: 'To monitor screen time',
            isGranted: _usageGranted,
            onRequest: _requestUsageAccess,
          ),
          const SizedBox(height: 12),
          _PermissionTile(
            icon: Icons.layers_rounded,
            title: 'Draw Over Apps',
            description: 'To gently pause your session',
            isGranted: _overlayGranted,
            onRequest: _requestOverlay,
          ),
          const SizedBox(height: 12),
          _PermissionTile(
            icon: Icons.notifications_rounded,
            title: 'Notifications',
            description: 'For your 25-minute reminder',
            isGranted: _notificationGranted,
            onRequest: _requestNotifications,
          ),
          const SizedBox(height: 32),
          if (_allGranted)
            PrimaryButton(
              label: 'Continue',
              onPressed: widget.onAllGranted,
              width: double.infinity,
            ).animate().fadeIn().scale(
                  begin: const Offset(0.9, 0.9),
                  end: const Offset(1, 1),
                ),
        ],
      ),
    );
  }
}

class _PermissionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final bool isGranted;
  final VoidCallback onRequest;

  const _PermissionTile({
    required this.icon,
    required this.title,
    required this.description,
    required this.isGranted,
    required this.onRequest,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isGranted ? null : onRequest,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isGranted
              ? NafsColors.primaryGreen.withValues(alpha: 0.3)
              : NafsColors.cardSurface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isGranted
                ? NafsColors.accentGold.withValues(alpha: 0.5)
                : NafsColors.accentGold.withValues(alpha: 0.1),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: NafsColors.accentGold, size: 28),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: NafsTextStyles.labelLarge),
                  const SizedBox(height: 2),
                  Text(description, style: NafsTextStyles.bodySmall),
                ],
              ),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: isGranted
                  ? const Icon(
                      Icons.check_circle_rounded,
                      color: NafsColors.accentGold,
                      size: 28,
                    )
                  : Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: NafsColors.accentGold),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Grant',
                        style: NafsTextStyles.labelMedium.copyWith(
                          color: NafsColors.accentGold,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
