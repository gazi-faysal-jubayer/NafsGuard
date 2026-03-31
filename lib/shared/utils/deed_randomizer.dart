import 'dart:math';
import '../../core/models/deed.dart';
import '../../core/models/deed_category.dart';

Deed randomizeDeed(List<Deed> allDeeds) {
  if (allDeeds.isEmpty) {
    throw ArgumentError('Deed list cannot be empty');
  }

  if (allDeeds.length == 1) return allDeeds.first;

  final random = Random();

  // Group by category
  final byCategory = <DeedCategory, List<Deed>>{};
  for (final deed in allDeeds) {
    byCategory.putIfAbsent(deed.category, () => []).add(deed);
  }

  // Weight equally by category so less-populated categories still appear
  final availableCategories = byCategory.keys.toList();
  final selectedCategory =
      availableCategories[random.nextInt(availableCategories.length)];

  final categoryDeeds = byCategory[selectedCategory]!;
  return categoryDeeds[random.nextInt(categoryDeeds.length)];
}
