import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/colors.dart';

class NafsAppBar extends StatelessWidget {
  final String? title;
  final List<Widget>? actions;
  final bool showBack;

  const NafsAppBar({
    super.key,
    this.title,
    this.actions,
    this.showBack = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 56,
          child: Row(
            children: [
              if (showBack)
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_rounded,
                    color: NafsColors.ivoryText,
                    size: 20,
                  ),
                  onPressed: () => Navigator.of(context).maybePop(),
                )
              else
                const SizedBox(width: 12),
              Expanded(
                child: Center(
                  child: title != null
                      ? Text(
                          title!,
                          style: GoogleFonts.amiri(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: NafsColors.ivoryText,
                          ),
                        )
                      : Text(
                          'NafsGuard',
                          style: GoogleFonts.amiri(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            color: NafsColors.accentGold,
                          ),
                        ),
                ),
              ),
              if (actions != null)
                Row(mainAxisSize: MainAxisSize.min, children: actions!)
              else
                const SizedBox(width: 48),
            ],
          ),
        ),
        CustomPaint(
          size: Size(MediaQuery.sizeOf(context).width, 2),
          painter: _BismillahDividerPainter(),
        ),
      ],
    );
  }
}

class _BismillahDividerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.transparent,
          NafsColors.accentGold.withValues(alpha: 0.6),
          Colors.transparent,
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, 1), paint);

    final dotPaint = Paint()..color = NafsColors.accentGold;
    canvas.drawCircle(Offset(size.width / 2, 0.5), 2.5, dotPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
