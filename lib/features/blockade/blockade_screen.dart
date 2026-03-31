import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/text_styles.dart';
import '../../core/providers/cycle_provider.dart';
import '../../core/providers/settings_provider.dart';
import '../../core/services/audio_service.dart';
import 'widgets/hold_button.dart';
import 'widgets/quote_display.dart';

class BlockadeScreen extends ConsumerStatefulWidget {
  const BlockadeScreen({super.key});

  @override
  ConsumerState<BlockadeScreen> createState() => _BlockadeScreenState();
}

class _BlockadeScreenState extends ConsumerState<BlockadeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final settings = ref.read(settingsProvider);
      AudioService().playBlockadeAlert(settings.audioPath);
    });
  }

  @override
  void dispose() {
    AudioService().stop();
    super.dispose();
  }

  void _onHoldComplete() {
    context.go('/deed-spin');
  }

  void _onBypass() {
    final settings = ref.read(settingsProvider);
    if (!settings.emergencyBypassEnabled) return;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: NafsColors.cardSurface,
        title: Text('Emergency Bypass', style: NafsTextStyles.headlineMedium),
        content: Text(
          'This will add ${settings.bypassPenaltyMinutes} minutes to your '
          'next cycle. Continue?',
          style: NafsTextStyles.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              ref.read(cycleStateProvider.notifier).bypass(
                    penaltyMinutes: settings.bypassPenaltyMinutes,
                  );
              context.go('/home');
            },
            child: Text(
              'Bypass',
              style: TextStyle(
                color: NafsColors.ashMuted.withValues(alpha: 0.8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);

    return Scaffold(
      backgroundColor: NafsColors.overlayBlack,
      body: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(painter: _StarFieldPainter()),
          ),
          SafeArea(
            child: Column(
              children: [
                const Spacer(flex: 2),
                const QuoteDisplay()
                    .animate()
                    .fadeIn(
                      duration: const Duration(milliseconds: 1200),
                      delay: const Duration(milliseconds: 400),
                    ),
                const Spacer(),
                HoldButton(onComplete: _onHoldComplete),
                const SizedBox(height: 16),
                Text(
                  'Hold to begin your deed',
                  style: NafsTextStyles.labelMedium,
                )
                    .animate()
                    .fadeIn(delay: const Duration(milliseconds: 800)),
                const Spacer(),
                if (settings.emergencyBypassEnabled)
                  TextButton(
                    onPressed: _onBypass,
                    child: Text(
                      'Emergency Bypass',
                      style: NafsTextStyles.bodySmall.copyWith(
                        color: NafsColors.ashMuted.withValues(alpha: 0.5),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StarFieldPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = NafsColors.accentGold.withValues(alpha: 0.03);
    final rng = [
      Offset(size.width * 0.1, size.height * 0.15),
      Offset(size.width * 0.8, size.height * 0.1),
      Offset(size.width * 0.3, size.height * 0.4),
      Offset(size.width * 0.9, size.height * 0.5),
      Offset(size.width * 0.15, size.height * 0.7),
      Offset(size.width * 0.7, size.height * 0.8),
      Offset(size.width * 0.5, size.height * 0.25),
      Offset(size.width * 0.6, size.height * 0.65),
    ];

    for (final pos in rng) {
      canvas.drawCircle(pos, 1.5, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
