import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';
import '../../../core/constants/durations.dart';
import '../../../shared/widgets/frosted_card.dart';

class CycleDurationSlider extends StatelessWidget {
  final int value;
  final ValueChanged<int> onChanged;

  const CycleDurationSlider({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return FrostedCard(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Cycle Length', style: NafsTextStyles.labelLarge),
              Text(
                '$value min',
                style: NafsTextStyles.labelLarge.copyWith(
                  color: NafsColors.accentGold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Slider(
            value: value.toDouble(),
            min: NafsDurations.minCycleMinutes.toDouble(),
            max: NafsDurations.maxCycleMinutes.toDouble(),
            divisions: (NafsDurations.maxCycleMinutes -
                NafsDurations.minCycleMinutes),
            label: '$value min',
            onChanged: (val) => onChanged(val.round()),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${NafsDurations.minCycleMinutes} min',
                style: NafsTextStyles.bodySmall,
              ),
              Text(
                '${NafsDurations.maxCycleMinutes} min',
                style: NafsTextStyles.bodySmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
