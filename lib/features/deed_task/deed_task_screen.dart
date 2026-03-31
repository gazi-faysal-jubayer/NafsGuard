import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/text_styles.dart';
import '../../core/models/deed.dart';
import '../../core/models/session.dart';
import '../../core/providers/cycle_provider.dart';
import '../../core/providers/sessions_provider.dart';
import '../../core/services/audio_service.dart';
import '../../core/services/overlay_service.dart';
import '../../shared/widgets/geometric_background.dart';
import '../../shared/widgets/primary_button.dart';
import 'widgets/deed_content_card.dart';
import 'widgets/deed_timer_ring.dart';
import 'widgets/completion_overlay.dart';

class DeedTaskScreen extends ConsumerStatefulWidget {
  final Deed deed;

  const DeedTaskScreen({super.key, required this.deed});

  @override
  ConsumerState<DeedTaskScreen> createState() => _DeedTaskScreenState();
}

class _DeedTaskScreenState extends ConsumerState<DeedTaskScreen> {
  bool _showCompletion = false;
  bool _completed = false;

  Future<void> _completeDeed() async {
    if (_completed) return;
    _completed = true;

    HapticFeedback.heavyImpact();

    final session = Session(
      id: const Uuid().v4(),
      startTime: DateTime.now(),
      endTime: DateTime.now(),
      deedCompleted: widget.deed,
      barakahEarned: 1,
    );

    await ref.read(sessionsRepositoryProvider).addSession(session);
    ref.invalidate(sessionsProvider);
    ref.read(cycleStateProvider.notifier).completeDeed();
    await OverlayService.dismissBlockade();
    AudioService().playCompletionChime();

    setState(() => _showCompletion = true);

    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GeometricBackground(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    Text(
                      'Your Deed',
                      style: NafsTextStyles.displayMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Complete this to earn Barakah',
                      style: NafsTextStyles.bodyMedium.copyWith(
                        color: NafsColors.ashMuted,
                      ),
                    ),
                    const Spacer(),
                    DeedContentCard(deed: widget.deed),
                    const SizedBox(height: 32),
                    if (widget.deed.durationSeconds != null)
                      DeedTimerRing(
                        durationSeconds: widget.deed.durationSeconds!,
                        onComplete: _completeDeed,
                      )
                    else
                      PrimaryButton(
                        label: "I've Done This",
                        onPressed: _completeDeed,
                        width: double.infinity,
                      ),
                    const Spacer(),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
          if (_showCompletion) const CompletionOverlay(),
        ],
      ),
    );
  }
}
