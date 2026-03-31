import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';
import '../../../shared/widgets/frosted_card.dart';

class BypassSettings extends StatelessWidget {
  final bool enabled;
  final int penaltyMinutes;
  final VoidCallback onToggle;
  final ValueChanged<int> onPenaltyChanged;

  const BypassSettings({
    super.key,
    required this.enabled,
    required this.penaltyMinutes,
    required this.onToggle,
    required this.onPenaltyChanged,
  });

  @override
  Widget build(BuildContext context) {
    return FrostedCard(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Allow Emergency Bypass',
                      style: NafsTextStyles.labelLarge,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Skip a deed with a time penalty',
                      style: NafsTextStyles.bodySmall,
                    ),
                  ],
                ),
              ),
              Switch(
                value: enabled,
                onChanged: (_) => onToggle(),
              ),
            ],
          ),
          if (enabled) ...[
            const SizedBox(height: 16),
            Divider(
              color: NafsColors.accentGold.withValues(alpha: 0.1),
              height: 1,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Penalty', style: NafsTextStyles.labelLarge),
                Text(
                  '$penaltyMinutes min',
                  style: NafsTextStyles.labelLarge.copyWith(
                    color: NafsColors.accentGold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Slider(
              value: penaltyMinutes.toDouble(),
              min: 5,
              max: 30,
              divisions: 5,
              label: '$penaltyMinutes min',
              onChanged: (val) => onPenaltyChanged(val.round()),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('5 min', style: NafsTextStyles.bodySmall),
                Text('30 min', style: NafsTextStyles.bodySmall),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
