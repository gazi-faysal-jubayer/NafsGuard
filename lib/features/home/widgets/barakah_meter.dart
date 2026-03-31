import 'dart:math';
import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';

class BarakahMeter extends StatefulWidget {
  final int deedsToday;
  final int streak;
  final int maxDeeds;

  const BarakahMeter({
    super.key,
    required this.deedsToday,
    required this.streak,
    this.maxDeeds = 10,
  });

  @override
  State<BarakahMeter> createState() => _BarakahMeterState();
}

class _BarakahMeterState extends State<BarakahMeter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _animation = Tween<double>(begin: 0, end: _progress).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    _controller.forward();
  }

  double get _progress =>
      (widget.deedsToday / widget.maxDeeds).clamp(0.0, 1.0);

  @override
  void didUpdateWidget(BarakahMeter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.deedsToday != widget.deedsToday) {
      _animation = Tween<double>(
        begin: _animation.value,
        end: _progress,
      ).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
      );
      _controller
        ..reset()
        ..forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final shouldGlow = widget.streak > 5;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          decoration: shouldGlow
              ? BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: NafsColors.accentGold.withValues(alpha: 0.3),
                      blurRadius: 30,
                      spreadRadius: 5,
                    ),
                  ],
                )
              : null,
          child: SizedBox(
            width: 200,
            height: 200,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomPaint(
                  size: const Size(200, 200),
                  painter: _BarakahRingPainter(
                    progress: _animation.value,
                    glowing: shouldGlow,
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.streak > 1)
                      Text(
                        '🔥',
                        style: TextStyle(
                          fontSize: shouldGlow ? 24 : 18,
                        ),
                      ),
                    Text(
                      '${widget.deedsToday}',
                      style: NafsTextStyles.displayLarge.copyWith(
                        fontSize: 48,
                        color: NafsColors.accentGold,
                      ),
                    ),
                    Text(
                      'Barakah',
                      style: NafsTextStyles.labelMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _BarakahRingPainter extends CustomPainter {
  final double progress;
  final bool glowing;

  _BarakahRingPainter({required this.progress, this.glowing = false});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 12;
    const strokeWidth = 8.0;

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
  bool shouldRepaint(_BarakahRingPainter oldDelegate) =>
      progress != oldDelegate.progress || glowing != oldDelegate.glowing;
}
