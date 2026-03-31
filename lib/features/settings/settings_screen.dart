import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/text_styles.dart';
import '../../core/providers/settings_provider.dart';
import '../../shared/widgets/geometric_background.dart';
import '../../shared/widgets/nafs_app_bar.dart';
import 'widgets/audio_picker.dart';
import 'widgets/bypass_settings.dart';
import 'widgets/custom_deed_manager.dart';
import 'widgets/cycle_duration_slider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);

    return Scaffold(
      body: GeometricBackground(
        child: SafeArea(
          child: Column(
            children: [
              const NafsAppBar(title: 'Settings', showBack: true),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    const SizedBox(height: 16),
                    const _SectionHeader(title: 'Cycle Duration'),
                    CycleDurationSlider(
                      value: settings.cycleDurationMinutes,
                      onChanged: (val) {
                        ref
                            .read(settingsProvider.notifier)
                            .updateCycleDuration(val);
                      },
                    ),
                    const SizedBox(height: 24),
                    const _SectionHeader(title: 'Audio Cue'),
                    AudioPicker(
                      selectedPath: settings.audioPath,
                      onChanged: (path) {
                        ref
                            .read(settingsProvider.notifier)
                            .updateAudioPath(path);
                      },
                    ),
                    const SizedBox(height: 24),
                    const _SectionHeader(title: 'Custom Deeds'),
                    const CustomDeedManager(),
                    const SizedBox(height: 24),
                    const _SectionHeader(title: 'Emergency Bypass'),
                    BypassSettings(
                      enabled: settings.emergencyBypassEnabled,
                      penaltyMinutes: settings.bypassPenaltyMinutes,
                      onToggle: () {
                        ref.read(settingsProvider.notifier).toggleBypass();
                      },
                      onPenaltyChanged: (val) {
                        ref
                            .read(settingsProvider.notifier)
                            .updateBypassPenalty(val);
                      },
                    ),
                    const SizedBox(height: 24),
                    const _SectionHeader(title: 'About'),
                    _AboutSection(),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(title, style: NafsTextStyles.headlineMedium),
    );
  }
}

class _AboutSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: NafsColors.cardSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: NafsColors.accentGold.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'NafsGuard',
            style: NafsTextStyles.labelLarge.copyWith(
              color: NafsColors.accentGold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'The Digital Gatekeeper — A Spiritual Screen Time Companion',
            style: NafsTextStyles.bodySmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Version 1.0.0',
            style: NafsTextStyles.bodySmall.copyWith(
              color: NafsColors.ashMuted.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }
}
