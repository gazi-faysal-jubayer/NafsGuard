import 'package:flutter/material.dart';
import '../../../core/constants/assets.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';
import '../../../core/services/audio_service.dart';
import '../../../shared/widgets/frosted_card.dart';

class AudioPicker extends StatelessWidget {
  final String selectedPath;
  final ValueChanged<String> onChanged;

  const AudioPicker({
    super.key,
    required this.selectedPath,
    required this.onChanged,
  });

  static const _options = [
    (NafsAssets.adhanSnippet, 'Adhan Snippet'),
    (NafsAssets.dhikrSubhanallah, 'Dhikr Audio'),
  ];

  @override
  Widget build(BuildContext context) {
    return FrostedCard(
      child: Column(
        children: [
          ..._options.map((option) {
            final isSelected = selectedPath == option.$1;
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: GestureDetector(
                onTap: () => onChanged(option.$1),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? NafsColors.accentGold.withValues(alpha: 0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? NafsColors.accentGold.withValues(alpha: 0.4)
                          : Colors.transparent,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isSelected
                            ? Icons.radio_button_checked
                            : Icons.radio_button_off,
                        color: isSelected
                            ? NafsColors.accentGold
                            : NafsColors.ashMuted,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          option.$2,
                          style: NafsTextStyles.bodyMedium,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.play_circle_outline,
                          color: NafsColors.accentGold,
                          size: 22,
                        ),
                        onPressed: () {
                          AudioService().playPreview(option.$1);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
