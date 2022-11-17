import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spoonacular/presentation/widget/cooking_time.dart';

void main() {
  group('Cooking time test', () {
    testWidgets(
        'Receives a numeric value representing minutes, it should transform that value to hours and minutes',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CookingTime(
              time: TimeOfDay(
                hour: 2,
                minute: 5,
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(
        find.text('2h 5m'),
        findsOneWidget,
      );
    });
  });
}
