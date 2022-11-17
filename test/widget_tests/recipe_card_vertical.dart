import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:spoonacular/data/model/recipe_model.dart';
import 'package:spoonacular/presentation/controller/recipe_summary_controller.dart';
import 'package:spoonacular/presentation/widget/cooking_time.dart';
import 'package:spoonacular/presentation/widget/recipe_card.dart';
import 'package:spoonacular/presentation/widget/recipe_flags.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../recipe_mock_data.dart';

void main() {
  group('Recipe vertical card test', () {
    testWidgets(
        'A card should display the title of the recipe, its tags, an image and a cooking time widget',
        (tester) async {
      RecipeModel recipe =
          RecipeModel.fromJson(RecipeMockData.responseData['recipes']![0]);
      Get.put(RecipeSummaryController());
      await mockNetworkImagesFor(
        () async => await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: RecipeCard(
                recipe: recipe,
                cardIndex: 0,
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(
        find.text(recipe.title!),
        findsOneWidget,
      );
      expect(
        find.byType(CookingTime),
        findsOneWidget,
      );
      expect(
        find.byType(RecipeFlags),
        findsOneWidget,
      );
      expect(
        find.byType(Image),
        findsWidgets,
      );
    });
  });
}
