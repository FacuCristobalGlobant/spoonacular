import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spoonacular/presentation/widget/no_search_results.dart';

void main() {
  group('no recipes found widget test', () {
    testWidgets('should display an image and a message', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: NoSearchResults(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(
        find.text(
          'No recipes found',
        ),
        findsOneWidget,
      );
      expect(
        find.byType(Image),
        findsOneWidget,
      );
    });
  });
}
