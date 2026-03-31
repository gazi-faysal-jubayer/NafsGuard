import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';
import '../../../core/models/session.dart';
import '../../../shared/widgets/frosted_card.dart';

class SessionTile extends StatefulWidget {
  final Session session;

  const SessionTile({super.key, required this.session});

  @override
  State<SessionTile> createState() => _SessionTileState();
}

class _SessionTileState extends State<SessionTile> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final s = widget.session;
    final timeFormat = DateFormat('hh:mm a');
    final dateFormat = DateFormat('MMM d, yyyy');

    return GestureDetector(
      onTap: () => setState(() => _expanded = !_expanded),
      child: FrostedCard(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        s.deedCompleted?.title ?? 'Bypassed',
                        style: NafsTextStyles.labelLarge.copyWith(
                          color: s.bypassUsed
                              ? NafsColors.ashMuted
                              : NafsColors.ivoryText,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        timeFormat.format(s.startTime),
                        style: NafsTextStyles.bodySmall,
                      ),
                    ],
                  ),
                ),
                if (s.bypassUsed)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: NafsColors.ashMuted.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Bypassed',
                      style: NafsTextStyles.labelMedium.copyWith(
                        fontSize: 10,
                        color: NafsColors.ashMuted,
                      ),
                    ),
                  )
                else
                  Text(
                    '+${s.barakahEarned}',
                    style: NafsTextStyles.labelLarge.copyWith(
                      color: NafsColors.accentGold,
                    ),
                  ),
                const SizedBox(width: 8),
                Icon(
                  _expanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: NafsColors.ashMuted,
                  size: 20,
                ),
              ],
            ),
            if (_expanded) ...[
              const SizedBox(height: 12),
              Divider(
                color: NafsColors.accentGold.withValues(alpha: 0.1),
                height: 1,
              ),
              const SizedBox(height: 12),
              _DetailRow(
                label: 'Date',
                value: dateFormat.format(s.startTime),
              ),
              if (s.deedCompleted != null)
                _DetailRow(
                  label: 'Category',
                  value: s.deedCompleted!.category.displayName,
                ),
              _DetailRow(
                label: 'Barakah Earned',
                value: s.barakahEarned.toString(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: NafsTextStyles.bodySmall),
          Text(value, style: NafsTextStyles.labelMedium),
        ],
      ),
    );
  }
}
