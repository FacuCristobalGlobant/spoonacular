import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spoonacular/presentation/widget/recipe_flags.dart';

void main() {
  group('Recipe flags test', () {
    testWidgets('There should always be 9 tags', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: RecipeFlags(
              recipeProperties: <String, bool>{
                'cheap': false,
                'dairyFree': false,
                'glutenFree': false,
                'veryHealthy': false,
                'lowFodmap': false,
                'veryPopular': false,
                'sustainable': false,
                'vegan': false,
                'vegetarian': false,
              },
            ),
          ),
        ),
      );

      expect(
        find.byType(Tooltip),
        findsNWidgets(9),
      );
    });
  });
}
