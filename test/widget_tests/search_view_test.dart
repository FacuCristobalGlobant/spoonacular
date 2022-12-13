import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import 'package:network_image_mock/network_image_mock.dart';
import 'package:spoonacular/data/model/recipe_model.dart';
import 'package:spoonacular/presentation/controller/ingredients_controller.dart';
import 'package:spoonacular/presentation/controller/nutritional_value_controller.dart';
import 'package:spoonacular/presentation/controller/recipe_controller.dart';
import 'package:spoonacular/presentation/controller/recipe_filter_controller.dart';
import 'package:spoonacular/presentation/controller/recipe_summary_controller.dart';
import 'package:spoonacular/presentation/controller/search_results_controller.dart';
import 'package:spoonacular/presentation/controller/similar_recipes_controller.dart';
import 'package:spoonacular/presentation/view/search.dart';
import 'package:spoonacular/presentation/widget/recipe_grid_widget.dart';

import '../recipe_mock_data.dart';
import 'recipes_controller_mock.dart';

void main() {
  group('Home screen test', () {
    testWidgets('', (tester) async {
      SearchResultsController controller = MockSearchResultsController();
      RecipeFilterController filterController = RecipeFilterController();
      RecipeController recipeController = MockRecipeController();
      NutritionalValueController nutritionalValueController =
          MockNutritionalValueController();
      IngredientsController ingredientsController = MockIngredientsController();
      RecipeSummaryController summaryController = RecipeSummaryController();
      SimilarRecipesController similarRecipesController =
          MockSimilarRecipesController();
      Get.put(summaryController);
      Get.put(similarRecipesController);
      Get.put(recipeController);
      Get.put(nutritionalValueController);
      Get.put(ingredientsController);
      Get.put(controller);
      Get.put(filterController);
      Get.put(recipeController);

      (controller as MockSearchResultsController).setNewState(
        null,
        RxStatus.empty(),
      );

      await mockNetworkImagesFor(
        () async {
          await tester.pumpWidget(
            MaterialApp(
              home: SafeArea(
                child: Scaffold(
                  body: Search(),
                ),
              ),
            ),
          );

          expect(
            find.text(
              'Find recipes that fit your preferences',
              skipOffstage: false,
            ),
            findsOneWidget,
          );

          controller.setNewState(
            [RecipeModel.fromJson(RecipeMockData.responseData['recipes']![0])],
            RxStatus.success(),
          );

          await tester.pumpAndSettle();

          expect(
            find.byType(
              RecipeGrid,
              skipOffstage: false,
            ),
            findsOneWidget,
          );
        },
      );
    });
  });
}
