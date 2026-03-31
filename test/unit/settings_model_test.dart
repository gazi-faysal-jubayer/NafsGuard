import 'package:flutter_test/flutter_test.dart';
import 'package:nafsguard/core/models/settings_model.dart';

void main() {
  group('SettingsModel', () {
    test('default values are correct', () {
      const settings = SettingsModel();
      expect(settings.cycleDurationMinutes, 25);
      expect(settings.audioPath, 'assets/audio/adhan_snippet.mp3');
      expect(settings.emergencyBypassEnabled, isFalse);
      expect(settings.bypassPenaltyMinutes, 10);
      expect(settings.onboardingCompleted, isFalse);
    });

    test('copyWith creates modified copy', () {
      const settings = SettingsModel();
      final modified = settings.copyWith(
        cycleDurationMinutes: 30,
        emergencyBypassEnabled: true,
      );

      expect(modified.cycleDurationMinutes, 30);
      expect(modified.emergencyBypassEnabled, isTrue);
      expect(modified.audioPath, settings.audioPath);
    });

    test('serializes to JSON and back', () {
      const settings = SettingsModel(
        cycleDurationMinutes: 40,
        audioPath: 'custom.mp3',
        emergencyBypassEnabled: true,
        bypassPenaltyMinutes: 15,
        onboardingCompleted: true,
      );

      final json = settings.toJson();
      final restored = SettingsModel.fromJson(json);

      expect(restored.cycleDurationMinutes, 40);
      expect(restored.audioPath, 'custom.mp3');
      expect(restored.emergencyBypassEnabled, isTrue);
      expect(restored.bypassPenaltyMinutes, 15);
      expect(restored.onboardingCompleted, isTrue);
    });
  });
}
