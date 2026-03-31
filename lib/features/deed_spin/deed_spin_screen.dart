import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/text_styles.dart';
import '../../core/models/deed.dart';
import '../../core/providers/settings_provider.dart';
import '../../shared/utils/built_in_deeds.dart';
import '../../shared/utils/deed_randomizer.dart';
import '../../shared/widgets/geometric_background.dart';
import 'widgets/slot_spinner.dart';

class DeedSpinScreen extends ConsumerStatefulWidget {
  const DeedSpinScreen({super.key});

  @override
  ConsumerState<DeedSpinScreen> createState() => _DeedSpinScreenState();
}

class _DeedSpinScreenState extends ConsumerState<DeedSpinScreen> {
  Deed? _selectedDeed;
  bool _spinning = true;

  @override
  void initState() {
    super.initState();
    _loadDeedsAndSpin();
  }

  Future<void> _loadDeedsAndSpin() async {
    final customDeeds = await ref.read(settingsProvider.notifier).getCustomDeeds();
    final allDeeds = [...builtInDeeds, ...customDeeds];
    final selected = randomizeDeed(allDeeds);
    setState(() => _selectedDeed = selected);
  }

  void _onSpinComplete() {
    setState(() => _spinning = false);
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted && _selectedDeed != null) {
        context.go('/deed-task', extra: _selectedDeed);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GeometricBackground(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 40),
              Text(
                'Your Deed Awaits',
                style: NafsTextStyles.displayMedium,
              )
                  .animate()
                  .fadeIn()
                  .slideY(begin: -0.2, end: 0),
              const SizedBox(height: 8),
              Text(
                'The wheel of Barakah spins...',
                style: NafsTextStyles.bodyMedium.copyWith(
                  color: NafsColors.ashMuted,
                ),
              )
                  .animate()
                  .fadeIn(delay: const Duration(milliseconds: 300)),
              const Spacer(),
              if (_selectedDeed != null)
                SlotSpinner(
                  selectedDeed: _selectedDeed!,
                  onComplete: _onSpinComplete,
                ),
              const Spacer(),
              if (!_spinning && _selectedDeed != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: NafsColors.accentGold.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: NafsColors.accentGold.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          _selectedDeed!.title,
                          style: NafsTextStyles.headlineMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _selectedDeed!.category.displayName,
                          style: NafsTextStyles.labelMedium.copyWith(
                            color: NafsColors.accentGold,
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn().scale(
                        begin: const Offset(0.9, 0.9),
                        end: const Offset(1, 1),
                      ),
                ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
