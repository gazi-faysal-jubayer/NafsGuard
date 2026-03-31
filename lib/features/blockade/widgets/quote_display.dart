import 'dart:math';
import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';

class QuoteDisplay extends StatelessWidget {
  const QuoteDisplay({super.key});

  static const _quotes = [
    'Time is Amanah.\nHow will you spend this moment?',
    'Every second is a seed.\nPlant something that grows.',
    'The Prophet ﷺ said:\n"Take advantage of five before five..."',
    'Your screen waited.\nNow your soul calls.',
    'Pause. Breathe.\nRemember the One who gave you this breath.',
    'A deed of light\nin a moment of stillness.',
    'The best of you are those\nwho remember Allah often.',
  ];

  @override
  Widget build(BuildContext context) {
    final quote = _quotes[Random().nextInt(_quotes.length)];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          Text(
            '﷽',
            style: NafsTextStyles.arabicDisplay.copyWith(fontSize: 36),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Text(
            quote,
            style: NafsTextStyles.displaySmall.copyWith(
              color: NafsColors.ivoryText.withValues(alpha: 0.9),
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
