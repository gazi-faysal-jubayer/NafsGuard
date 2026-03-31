import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';
import '../../../core/models/deed.dart';
import '../../../core/providers/settings_provider.dart';
import '../../../shared/widgets/frosted_card.dart';
import '../../deed_spin/widgets/deed_category_badge.dart';
import 'deed_editor_bottom_sheet.dart';

class CustomDeedManager extends ConsumerWidget {
  const CustomDeedManager({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deedsAsync = ref.watch(customDeedsProvider);

    return FrostedCard(
      child: Column(
        children: [
          deedsAsync.when(
            data: (deeds) {
              if (deeds.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    'No custom deeds yet',
                    style: NafsTextStyles.bodySmall,
                  ),
                );
              }
              return Column(
                children: deeds.map((deed) {
                  return Dismissible(
                    key: Key(deed.id),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 16),
                      decoration: BoxDecoration(
                        color: Colors.red.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                      ),
                    ),
                    onDismissed: (_) {
                      ref
                          .read(settingsProvider.notifier)
                          .removeCustomDeed(deed.id);
                      ref.invalidate(customDeedsProvider);
                    },
                    child: _DeedRow(deed: deed),
                  );
                }).toList(),
              );
            },
            loading: () => const Padding(
              padding: EdgeInsets.all(12),
              child: CircularProgressIndicator(
                color: NafsColors.accentGold,
                strokeWidth: 2,
              ),
            ),
            error: (_, _) => Text(
              'Error loading deeds',
              style: NafsTextStyles.bodySmall,
            ),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => _showEditor(context, ref),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(
                  color: NafsColors.accentGold.withValues(alpha: 0.3),
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.add_rounded,
                    color: NafsColors.accentGold,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Add Custom Deed',
                    style: NafsTextStyles.labelLarge.copyWith(
                      color: NafsColors.accentGold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showEditor(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DeedEditorBottomSheet(
        onSave: (deed) {
          ref.read(settingsProvider.notifier).addCustomDeed(deed);
          ref.invalidate(customDeedsProvider);
        },
      ),
    );
  }
}

class _DeedRow extends StatelessWidget {
  final Deed deed;

  const _DeedRow({required this.deed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          DeedCategoryBadge(category: deed.category, compact: true),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              deed.title,
              style: NafsTextStyles.bodyMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (deed.durationSeconds != null)
            Text(
              '${deed.durationSeconds}s',
              style: NafsTextStyles.bodySmall,
            ),
        ],
      ),
    );
  }
}
