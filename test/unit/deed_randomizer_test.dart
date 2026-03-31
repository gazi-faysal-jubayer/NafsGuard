import 'package:flutter_test/flutter_test.dart';
import 'package:nafsguard/core/models/deed.dart';
import 'package:nafsguard/core/models/deed_category.dart';
import 'package:nafsguard/shared/utils/deed_randomizer.dart';
import 'package:nafsguard/shared/utils/built_in_deeds.dart';

void main() {
  group('DeedRandomizer', () {
    test('returns a valid Deed from the list', () {
      final result = randomizeDeed(builtInDeeds);
      expect(builtInDeeds.contains(result), isTrue);
    });

    test('throws on empty list', () {
      expect(() => randomizeDeed([]), throwsArgumentError);
    });

    test('returns the only deed when list has one item', () {
      const singleDeed = Deed(
        id: 'test',
        title: 'Test deed',
        category: DeedCategory.tongue,
      );
      final result = randomizeDeed([singleDeed]);
      expect(result, equals(singleDeed));
    });

    test('covers all categories over many runs', () {
      final categoriesSeen = <DeedCategory>{};
      for (int i = 0; i < 200; i++) {
        final deed = randomizeDeed(builtInDeeds);
        categoriesSeen.add(deed.category);
      }
      expect(categoriesSeen, containsAll(DeedCategory.values));
    });

    test('includes custom deeds in selection', () {
      const customDeed = Deed(
        id: 'custom_1',
        title: 'Custom test deed',
        category: DeedCategory.tongue,
        isCustom: true,
      );

      bool foundCustom = false;
      final allDeeds = [...builtInDeeds, customDeed];
      for (int i = 0; i < 200; i++) {
        final result = randomizeDeed(allDeeds);
        if (result.id == 'custom_1') {
          foundCustom = true;
          break;
        }
      }
      expect(foundCustom, isTrue);
    });
  });
}
