import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenTimeService {
  static const _prefKeyElapsed = 'cycle_elapsed_seconds';
  static const _prefKeyStart = 'cycle_start_ts';
  static const _prefKeyDuration = 'cycle_duration_seconds';
  static const _prefKeyPenalty = 'cycle_penalty_seconds';

  int cycleDurationSeconds = 25 * 60;

  Future<void> initialize() async {
    final service = FlutterBackgroundService();
    await service.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: _onBackgroundStart,
        autoStart: false,
        isForegroundMode: false,
        notificationChannelId: 'nafsguard_cycle',
        initialNotificationTitle: 'NafsGuard',
        initialNotificationContent: 'Cycle tracking active…',
        foregroundServiceNotificationId: 888,
      ),
      iosConfiguration: IosConfiguration(
        autoStart: false,
        onForeground: _onBackgroundStart,
        onBackground: _onIosBackground,
      ),
    );
  }

  Future<void> startTracking() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(
        _prefKeyStart, DateTime.now().millisecondsSinceEpoch ~/ 1000);
    await prefs.setInt(_prefKeyElapsed, 0);
    await prefs.setInt(_prefKeyDuration, cycleDurationSeconds);
    await prefs.setInt(_prefKeyPenalty, 0);
  }

  Future<void> addPenalty(int minutes) async {
    final prefs = await SharedPreferences.getInstance();
    final existing = prefs.getInt(_prefKeyPenalty) ?? 0;
    await prefs.setInt(_prefKeyPenalty, existing + minutes * 60);
  }

  Future<void> resetCycle() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(
        _prefKeyStart, DateTime.now().millisecondsSinceEpoch ~/ 1000);
    await prefs.setInt(_prefKeyElapsed, 0);
    final penalty = prefs.getInt(_prefKeyPenalty) ?? 0;
    final duration = prefs.getInt(_prefKeyDuration) ?? cycleDurationSeconds;
    await prefs.setInt(_prefKeyDuration, duration + penalty);
    await prefs.setInt(_prefKeyPenalty, 0);
  }

  Future<int> getElapsedSeconds() async {
    final prefs = await SharedPreferences.getInstance();
    final start = prefs.getInt(_prefKeyStart);
    if (start == null) return 0;
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    return (now - start).clamp(0, cycleDurationSeconds * 2);
  }
}

@pragma('vm:entry-point')
void _onBackgroundStart(ServiceInstance service) async {
  // Background isolate — intentionally minimal for now.
}

@pragma('vm:entry-point')
Future<bool> _onIosBackground(ServiceInstance service) async {
  return true;
}
