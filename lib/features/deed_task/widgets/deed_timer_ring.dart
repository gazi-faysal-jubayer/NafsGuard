import 'dart:math';
import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';
import '../../../shared/extensions/duration_ext.dart';

class DeedTimerRing extends StatefulWidget {
  final int durationSeconds;
  final VoidCallback onComplete;

  const DeedTimerRing({
    super.key,
    required this.durationSeconds,
    required this.onComplete,
  });

  @override
  State<DeedTimerRing> createState() => DeedTimerRingState();
}

class DeedTimerRingState extends State<DeedTimerRing>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.durationSeconds),
    );
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onComplete();
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final remaining =
            ((1 - _controller.value) * widget.durationSeconds).round();

        return SizedBox(
          width: 160,
          height: 160,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: const Size(160, 160),
                painter: _TimerRingPainter(
                  progress: 1 - _controller.value,
                ),
              ),
              Text(
                Duration(seconds: remaining).toCountdown(),
                style: NafsTextStyles.displayMedium.copyWith(
                  color: NafsColors.accentGold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TimerRingPainter extends CustomPainter {
  final double progress;

  _TimerRingPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 10;
    const strokeWidth = 6.0;

    final bgPaint = Paint()
      ..color = NafsColors.ashMuted.withValues(alpha: 0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, bgPaint);

    if (progress > 0) {
      final progressPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round
        ..shader = const SweepGradient(
          startAngle: -pi / 2,
          endAngle: 3 * pi / 2,
          colors: [NafsColors.accentGold, NafsColors.softGoldLight],
        ).createShader(Rect.fromCircle(center: center, radius: radius));

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
  bool shouldRepaint(_TimerRingPainter oldDelegate) =>
      progress != oldDelegate.progress;
}
