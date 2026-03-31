import 'dart:math';
import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';
import '../../../shared/extensions/duration_ext.dart';

class CycleCountdownRing extends StatelessWidget {
  final int remainingSeconds;
  final int totalSeconds;

  const CycleCountdownRing({
    super.key,
    required this.remainingSeconds,
    required this.totalSeconds,
  });

  @override
  Widget build(BuildContext context) {
    final progress = totalSeconds > 0 ? remainingSeconds / totalSeconds : 0.0;

    return SizedBox(
      width: 100,
      height: 100,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size(100, 100),
            painter: _CountdownRingPainter(progress: progress),
          ),
          Text(
            Duration(seconds: remainingSeconds).toCountdown(),
            style: NafsTextStyles.labelLarge.copyWith(
              fontSize: 16,
              color: NafsColors.ivoryText,
            ),
          ),
        ],
      ),
    );
  }
}

class _CountdownRingPainter extends CustomPainter {
  final double progress;

  _CountdownRingPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 6;
    const strokeWidth = 3.0;

    final bgPaint = Paint()
      ..color = NafsColors.ashMuted.withValues(alpha: 0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, bgPaint);

    if (progress > 0) {
      final progressPaint = Paint()
        ..color = NafsColors.accentGold.withValues(alpha: 0.6)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -pi / 2,
        2 * pi * progress,
        false,
        progressPaint,
      );
    }
  }

  @override
  bool shouldRepaint(_CountdownRingPainter oldDelegate) =>
      progress != oldDelegate.progress;
}
