import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nafsguard/features/deed_task/widgets/deed_timer_ring.dart';

void main() {
  group('DeedTimerRing', () {
    testWidgets('renders countdown text', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DeedTimerRing(
              durationSeconds: 30,
              onComplete: () {},
            ),
          ),
        ),
      );

      expect(find.text('00:30'), findsOneWidget);
    });

    testWidgets('counts down over time', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DeedTimerRing(
              durationSeconds: 10,
              onComplete: () {},
            ),
          ),
        ),
      );

      await tester.pump(const Duration(seconds: 5));
      expect(find.text('00:05'), findsOneWidget);
    });

    testWidgets('calls onComplete when timer finishes', (tester) async {
      bool completed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DeedTimerRing(
              durationSeconds: 2,
              onComplete: () => completed = true,
            ),
          ),
        ),
      );

      await tester.pump(const Duration(seconds: 3));
      expect(completed, isTrue);
    });
  });
}
