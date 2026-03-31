import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/constants/text_styles.dart';
import '../../../core/models/deed.dart';
import '../../../shared/widgets/frosted_card.dart';
import '../../deed_spin/widgets/deed_category_badge.dart';

class DeedContentCard extends StatelessWidget {
  final Deed deed;

  const DeedContentCard({super.key, required this.deed});

  @override
  Widget build(BuildContext context) {
    return FrostedCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          DeedCategoryBadge(category: deed.category),
          const SizedBox(height: 16),
          Text(
            deed.title,
            style: NafsTextStyles.displaySmall.copyWith(height: 1.5),
            textAlign: TextAlign.center,
          ),
          if (deed.durationSeconds != null) ...[
            const SizedBox(height: 12),
            Text(
              '${deed.durationSeconds} seconds',
              style: NafsTextStyles.labelMedium,
            ),
          ],
        ],
      ),
    )
        .animate()
        .fadeIn(duration: const Duration(milliseconds: 600))
        .slideY(begin: 0.1, end: 0);
  }
}
