import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/text_styles.dart';
import '../../core/providers/sessions_provider.dart';
import '../../shared/widgets/geometric_background.dart';
import '../../shared/widgets/nafs_app_bar.dart';
import 'widgets/session_tile.dart';
import 'widgets/weekly_chart.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionsAsync = ref.watch(sessionsProvider);
    final weeklyAsync = ref.watch(weeklyDeedsProvider);

    return Scaffold(
      body: GeometricBackground(
        child: SafeArea(
          child: Column(
            children: [
              const NafsAppBar(title: 'History', showBack: true),
              Expanded(
                child: sessionsAsync.when(
                  data: (sessions) {
                    if (sessions.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.history_rounded,
                              size: 64,
                              color:
                                  NafsColors.ashMuted.withValues(alpha: 0.3),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No sessions yet',
                              style: NafsTextStyles.bodyLarge.copyWith(
                                color: NafsColors.ashMuted,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Complete your first deed to begin',
                              style: NafsTextStyles.bodySmall,
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: [
                        const SizedBox(height: 16),
                        weeklyAsync.when(
                          data: (data) => WeeklyChart(data: data),
                          loading: () => const SizedBox(height: 200),
                          error: (_, _) => const SizedBox.shrink(),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Recent Sessions',
                          style: NafsTextStyles.headlineMedium,
                        ),
                        const SizedBox(height: 12),
                        ...sessions.map(
                          (session) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: SessionTile(session: session),
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    );
                  },
                  loading: () => _ShimmerLoading(),
                  error: (_, _) => Center(
                    child: Text(
                      'Error loading sessions',
                      style: NafsTextStyles.bodyMedium,
                    ),
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

class _ShimmerLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: NafsColors.cardSurface,
      highlightColor: NafsColors.primaryGreen,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 6,
        itemBuilder: (context, index) => Container(
          height: 72,
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: NafsColors.cardSurface,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
