import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/settings_model.dart';
import '../models/deed.dart';

class SettingsNotifier extends StateNotifier<SettingsModel> {
  SettingsNotifier() : super(const SettingsModel()) {
    _loadSettings();
  }

  static const _boxName = 'settings_box';

  Future<void> _loadSettings() async {
    final box = await Hive.openBox<SettingsModel>(_boxName);
    final saved = box.get('settings');
    if (saved != null) {
      state = saved;
    }
  }

  Future<void> _persist() async {
    final box = await Hive.openBox<SettingsModel>(_boxName);
    await box.put('settings', state);
  }

  Future<void> updateCycleDuration(int minutes) async {
    state = state.copyWith(cycleDurationMinutes: minutes);
    await _persist();
  }

  Future<void> updateAudioPath(String path) async {
    state = state.copyWith(audioPath: path);
    await _persist();
  }

  Future<void> toggleBypass() async {
    state = state.copyWith(
      emergencyBypassEnabled: !state.emergencyBypassEnabled,
    );
    await _persist();
  }

  Future<void> updateBypassPenalty(int minutes) async {
    state = state.copyWith(bypassPenaltyMinutes: minutes);
    await _persist();
  }

  Future<void> completeOnboarding() async {
    state = state.copyWith(onboardingCompleted: true);
    await _persist();
  }

  Future<void> addCustomDeed(Deed deed) async {
    final box = await Hive.openBox<Deed>('custom_deeds_box');
    await box.put(deed.id, deed);
  }

  Future<void> removeCustomDeed(String id) async {
    final box = await Hive.openBox<Deed>('custom_deeds_box');
    await box.delete(id);
  }

  Future<List<Deed>> getCustomDeeds() async {
    final box = await Hive.openBox<Deed>('custom_deeds_box');
    return box.values.toList();
  }
}

final settingsProvider =
    StateNotifierProvider<SettingsNotifier, SettingsModel>((ref) {
  return SettingsNotifier();
});

final customDeedsProvider = FutureProvider<List<Deed>>((ref) async {
  final notifier = ref.read(settingsProvider.notifier);
  return notifier.getCustomDeeds();
});
