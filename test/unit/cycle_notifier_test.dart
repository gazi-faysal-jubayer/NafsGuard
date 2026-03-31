import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nafsguard/core/providers/cycle_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('CycleNotifier', () {
    late CycleNotifier notifier;

    setUp(() {
      WidgetsFlutterBinding.ensureInitialized();
      SharedPreferences.setMockInitialValues({});
      notifier = CycleNotifier();
    });

    tearDown(() {
      notifier.dispose();
    });

    test('initial state is not running and not blocked', () {
      expect(notifier.state.isRunning, isFalse);
      expect(notifier.state.isBlocked, isFalse);
      expect(notifier.state.elapsedSeconds, 0);
    });

    test('triggerBlockade sets isBlocked to true', () {
      notifier.triggerBlockade();
      expect(notifier.state.isBlocked, isTrue);
      expect(notifier.state.isRunning, isFalse);
    });

    test('completeDeed clears blocked state', () {
      notifier.triggerBlockade();
      expect(notifier.state.isBlocked, isTrue);

      notifier.completeDeed();
      expect(notifier.state.isBlocked, isFalse);
      expect(notifier.state.currentDeed, isNull);
    });

    test('bypass increments bypass count', () {
      notifier.triggerBlockade();
      notifier.bypass();
      expect(notifier.state.bypassCount, 1);
      expect(notifier.state.isBlocked, isFalse);

      notifier.triggerBlockade();
      notifier.bypass();
      expect(notifier.state.bypassCount, 2);
    });

    test('tick increments elapsed seconds', () {
      notifier.triggerBlockade(); // set running to false first
      notifier.completeDeed(); // this calls resetCycle which sets running to true

      notifier.tick();
      expect(notifier.state.elapsedSeconds, 1);
    });

    test('updateDuration changes total seconds', () {
      notifier.updateDuration(30);
      expect(notifier.state.totalSeconds, 1800);
    });

    test('remainingSeconds is computed correctly', () {
      notifier.updateDuration(25);
      expect(notifier.state.remainingSeconds, 1500);

      // Simulate elapsed
      notifier.triggerBlockade();
      notifier.completeDeed();
      for (int i = 0; i < 10; i++) {
        notifier.tick();
      }
      expect(notifier.state.remainingSeconds, 1490);
    });
  });
}
