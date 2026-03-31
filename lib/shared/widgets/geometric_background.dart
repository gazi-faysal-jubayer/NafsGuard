import 'dart:math';
import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';

class GeometricBackground extends StatelessWidget {
  final Widget child;

  const GeometricBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: NafsColors.primaryDark,
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: _GeometricTilePainter(),
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.2,
                  colors: [
                    Colors.transparent,
                    NafsColors.primaryDark.withValues(alpha: 0.7),
                    NafsColors.primaryDark,
                  ],
                  stops: const [0.0, 0.6, 1.0],
                ),
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}

class _GeometricTilePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = NafsColors.accentGold.withValues(alpha: 0.04)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;

    const tileSize = 60.0;
    final cols = (size.width / tileSize).ceil() + 1;
    final rows = (size.height / tileSize).ceil() + 1;

    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < cols; col++) {
        final cx = col * tileSize + tileSize / 2;
        final cy = row * tileSize + tileSize / 2;
        _drawIslamicStar(canvas, Offset(cx, cy), tileSize / 2.5, paint);
      }
    }
  }

  void _drawIslamicStar(
      Canvas canvas, Offset center, double radius, Paint paint) {
    final path = Path();
    for (int i = 0; i < 8; i++) {
      final outerAngle = (i * pi / 4) - pi / 2;
      final innerAngle = outerAngle + pi / 8;
      final outerX = center.dx + radius * cos(outerAngle);
      final outerY = center.dy + radius * sin(outerAngle);
      final innerX = center.dx + (radius * 0.4) * cos(innerAngle);
      final innerY = center.dy + (radius * 0.4) * sin(innerAngle);

      if (i == 0) {
        path.moveTo(outerX, outerY);
      } else {
        path.lineTo(outerX, outerY);
      }
      path.lineTo(innerX, innerY);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
