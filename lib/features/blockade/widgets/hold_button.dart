import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/durations.dart';

class HoldButton extends StatefulWidget {
  final VoidCallback onComplete;

  const HoldButton({super.key, required this.onComplete});

  @override
  State<HoldButton> createState() => _HoldButtonState();
}

class _HoldButtonState extends State<HoldButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isHolding = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: NafsDurations.holdButton,
    );
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        HapticFeedback.mediumImpact();
        widget.onComplete();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPressStart() {
    setState(() => _isHolding = true);
    HapticFeedback.lightImpact();
    _controller.forward();
  }

  void _onPressEnd() {
    if (_controller.status != AnimationStatus.completed) {
      _controller.reset();
    }
    setState(() => _isHolding = false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: (_) => _onPressStart(),
      onLongPressEnd: (_) => _onPressEnd(),
      onLongPressCancel: () => _onPressEnd(),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: _isHolding
                ? BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: NafsColors.accentGold
                            .withValues(alpha: 0.2 + _controller.value * 0.4),
                        blurRadius: 20 + _controller.value * 30,
                        spreadRadius: _controller.value * 10,
                      ),
                    ],
                  )
                : null,
            child: SizedBox(
              width: 140,
              height: 140,
              child: CustomPaint(
                painter: _IslamicStarButtonPainter(
                  progress: _controller.value,
                  isHolding: _isHolding,
                ),
                child: Center(
                  child: Semantics(
                    label: 'Hold for two seconds to begin your deed',
                    child: const SizedBox.shrink(),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _IslamicStarButtonPainter extends CustomPainter {
  final double progress;
  final bool isHolding;

  _IslamicStarButtonPainter({
    required this.progress,
    required this.isHolding,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final outerRadius = size.width / 2 - 4;
    final innerRadius = outerRadius * 0.4;

    // Outer star shape
    final starPath = _buildStarPath(center, outerRadius, innerRadius, 8);

    // Background fill
    final bgPaint = Paint()
      ..color = NafsColors.primaryGreen.withValues(alpha: 0.6)
      ..style = PaintingStyle.fill;
    canvas.drawPath(starPath, bgPaint);

    // Progress fill (inner ring that fills up)
    if (progress > 0) {
      final progressRadius = outerRadius * 0.65;
      final progressPaint = Paint()
        ..color = NafsColors.accentGold.withValues(alpha: 0.3 + progress * 0.5)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: progressRadius),
        -pi / 2,
        2 * pi * progress,
        false,
        progressPaint,
      );
    }

    // Star outline
    final outlinePaint = Paint()
      ..color = isHolding
          ? NafsColors.accentGold
          : NafsColors.accentGold.withValues(alpha: 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawPath(starPath, outlinePaint);

    // Center glow dot
    final glowPaint = Paint()
      ..color = NafsColors.accentGold.withValues(alpha: 0.4 + progress * 0.6)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
    canvas.drawCircle(center, 8 + progress * 4, glowPaint);

    final dotPaint = Paint()..color = NafsColors.accentGold;
    canvas.drawCircle(center, 4, dotPaint);
  }

  Path _buildStarPath(
      Offset center, double outerR, double innerR, int points) {
    final path = Path();
    for (int i = 0; i < points; i++) {
      final outerAngle = (i * 2 * pi / points) - pi / 2;
      final innerAngle = outerAngle + pi / points;
      final ox = center.dx + outerR * cos(outerAngle);
      final oy = center.dy + outerR * sin(outerAngle);
      final ix = center.dx + innerR * cos(innerAngle);
      final iy = center.dy + innerR * sin(innerAngle);
      if (i == 0) {
        path.moveTo(ox, oy);
      } else {
        path.lineTo(ox, oy);
      }
      path.lineTo(ix, iy);
    }
    path.close();
    return path;
  }

  @override
  bool shouldRepaint(_IslamicStarButtonPainter oldDelegate) =>
      progress != oldDelegate.progress || isHolding != oldDelegate.isHolding;
}
