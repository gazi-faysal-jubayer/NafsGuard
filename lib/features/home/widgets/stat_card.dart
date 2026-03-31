import 'package:flutter/material.dart';
import '../../../core/constants/text_styles.dart';
import '../../../shared/widgets/frosted_card.dart';

class StatCard extends StatelessWidget {
  final String label;
  final String value;
  final bool showFlame;

  const StatCard({
    super.key,
    required this.label,
    required this.value,
    this.showFlame = false,
  });

  @override
  Widget build(BuildContext context) {
    return FrostedCard(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (showFlame)
                const Padding(
                  padding: EdgeInsets.only(right: 4),
                  child: Text('🔥', style: TextStyle(fontSize: 14)),
                ),
              Flexible(
                child: Text(
                  value,
                  style: NafsTextStyles.displaySmall,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: NafsTextStyles.labelMedium,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
