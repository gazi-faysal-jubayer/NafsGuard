import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nafsguard/features/blockade/widgets/hold_button.dart';

void main() {
  group('HoldButton', () {
    testWidgets('renders without error', (tester) async {
      bool completed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: HoldButton(onComplete: () => completed = true),
            ),
          ),
        ),
      );

      expect(find.byType(HoldButton), findsOneWidget);
      expect(completed, isFalse);
    });

    testWidgets('does not complete on short press', (tester) async {
      bool completed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: HoldButton(onComplete: () => completed = true),
            ),
          ),
        ),
      );

      final gesture = await tester.startGesture(
        tester.getCenter(find.byType(HoldButton)),
      );
      await tester.pump(const Duration(milliseconds: 500));
      await gesture.up();
      await tester.pumpAndSettle();

      expect(completed, isFalse);
    });

    testWidgets('completes after 2000ms hold', (tester) async {
      bool completed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: HoldButton(onComplete: () => completed = true),
            ),
          ),
        ),
      );

      final gesture = await tester.startGesture(
        tester.getCenter(find.byType(HoldButton)),
      );
      await tester.pump(const Duration(milliseconds: 2100));
      await gesture.up();
      await tester.pumpAndSettle();

      expect(completed, isTrue);
    });
  });
}
