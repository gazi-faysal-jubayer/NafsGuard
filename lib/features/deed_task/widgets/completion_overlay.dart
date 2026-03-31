import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';

class CompletionOverlay extends StatefulWidget {
  const CompletionOverlay({super.key});

  @override
  State<CompletionOverlay> createState() => _CompletionOverlayState();
}

class _CompletionOverlayState extends State<CompletionOverlay> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 3),
    );
    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: NafsColors.overlayBlack,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [
                NafsColors.accentGold,
                NafsColors.softGoldLight,
                NafsColors.primaryGreen,
                Color(0xFF2D6A4F),
              ],
              numberOfParticles: 30,
              gravity: 0.2,
              emissionFrequency: 0.05,
              maxBlastForce: 15,
              minBlastForce: 5,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'بَرَكَة',
                style: NafsTextStyles.arabicDisplay.copyWith(
                  fontSize: 56,
                ),
              )
                  .animate()
                  .fadeIn(duration: const Duration(milliseconds: 800))
                  .scale(
                    begin: const Offset(0.5, 0.5),
                    end: const Offset(1, 1),
                    curve: Curves.elasticOut,
                    duration: const Duration(milliseconds: 1000),
                  ),
              const SizedBox(height: 16),
              Text(
                'Barakah +1',
                style: NafsTextStyles.displaySmall.copyWith(
                  color: NafsColors.accentGold,
                ),
              )
                  .animate()
                  .fadeIn(delay: const Duration(milliseconds: 500))
                  .slideY(begin: 0.3, end: 0),
              const SizedBox(height: 8),
              Text(
                'May Allah accept your deed',
                style: NafsTextStyles.bodyMedium.copyWith(
                  color: NafsColors.ashMuted,
                ),
              )
                  .animate()
                  .fadeIn(delay: const Duration(milliseconds: 800)),
            ],
          ),
        ],
      ),
    );
  }
}
