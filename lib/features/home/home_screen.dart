import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/text_styles.dart';
import '../../core/providers/cycle_provider.dart';
import '../../core/providers/sessions_provider.dart';
import '../../shared/widgets/geometric_background.dart';
import '../../shared/widgets/nafs_app_bar.dart';
import 'widgets/barakah_meter.dart';
import 'widgets/cycle_countdown_ring.dart';
import 'widgets/stat_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cycle = ref.read(cycleStateProvider);
      if (!cycle.isRunning && !cycle.isBlocked) {
        ref.read(cycleStateProvider.notifier).startCycle();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final cycleState = ref.watch(cycleStateProvider);
    final barakahAsync = ref.watch(barakahTodayProvider);
    final streakAsync = ref.watch(streakProvider);
    final weeklyAsync = ref.watch(weeklyDeedsProvider);

    if (cycleState.isBlocked) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go('/blockade');
      });
    }

    return Scaffold(
      body: GeometricBackground(
        child: SafeArea(
          child: Column(
            children: [
              NafsAppBar(
                actions: [
                  IconButton(
                    icon: const Icon(Icons.settings_outlined),
                    onPressed: () => context.push('/settings'),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      const SizedBox(height: 24),
                      barakahAsync.when(
                        data: (count) => BarakahMeter(
                          deedsToday: count,
                          streak: streakAsync.valueOrNull ?? 0,
                        ),
                        loading: () => const BarakahMeter(
                          deedsToday: 0,
                          streak: 0,
                        ),
                        error: (_, _) => const BarakahMeter(
                          deedsToday: 0,
                          streak: 0,
                        ),
                      ),
                      const SizedBox(height: 24),
                      CycleCountdownRing(
                        remainingSeconds: cycleState.remainingSeconds,
                        totalSeconds: cycleState.totalSeconds,
                      ),
                      const SizedBox(height: 32),
                      Row(
                        children: [
                          Expanded(
                            child: StatCard(
                              label: "Today's Deeds",
                              value: barakahAsync.valueOrNull?.toString() ??
                                  '0',
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: StatCard(
                              label: 'Streak',
                              value:
                                  '${streakAsync.valueOrNull ?? 0} days',
                              showFlame:
                                  (streakAsync.valueOrNull ?? 0) > 1,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: StatCard(
                              label: 'This Week',
                              value: weeklyAsync.when(
                                data: (m) => m.values
                                    .fold(0, (a, b) => a + b)
                                    .toString(),
                                loading: () => '...',
                                error: (_, _) => '0',
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      Row(
                        children: [
                          Expanded(
                            child: _GhostButton(
                              label: 'View History',
                              onTap: () => context.push('/history'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _GhostButton(
                              label: 'Manage Deeds',
                              onTap: () => context.push('/settings'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GhostButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _GhostButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: NafsColors.accentGold.withValues(alpha: 0.3),
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: NafsTextStyles.labelLarge.copyWith(
              color: NafsColors.accentGold,
            ),
          ),
        ),
      ),
    );
  }
}
