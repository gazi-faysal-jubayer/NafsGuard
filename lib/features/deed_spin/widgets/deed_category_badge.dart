import 'package:flutter/material.dart';
import '../../../core/constants/text_styles.dart';
import '../../../core/models/deed_category.dart';

class DeedCategoryBadge extends StatelessWidget {
  final DeedCategory category;
  final bool compact;

  const DeedCategoryBadge({
    super.key,
    required this.category,
    this.compact = false,
  });

  Color get _color {
    switch (category) {
      case DeedCategory.tongue:
        return const Color(0xFF4ECDC4);
      case DeedCategory.action:
        return const Color(0xFFFF6B6B);
      case DeedCategory.knowledge:
        return const Color(0xFF45B7D1);
      case DeedCategory.physical:
        return const Color(0xFFFFA07A);
    }
  }

  IconData get _icon {
    switch (category) {
      case DeedCategory.tongue:
        return Icons.record_voice_over_rounded;
      case DeedCategory.action:
        return Icons.volunteer_activism_rounded;
      case DeedCategory.knowledge:
        return Icons.menu_book_rounded;
      case DeedCategory.physical:
        return Icons.self_improvement_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (compact) {
      return Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: _color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(_icon, size: 16, color: _color),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_icon, size: 14, color: _color),
          const SizedBox(width: 4),
          Text(
            category.displayName,
            style: NafsTextStyles.labelMedium.copyWith(
              color: _color,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
