import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:spoonacular/data/model/ingredient_model.dart';
import 'package:spoonacular/data/model/recipe_model.dart';
import 'package:spoonacular/presentation/controller/ingredients_controller.dart';
import 'package:spoonacular/presentation/controller/nutritional_value_controller.dart';
import 'package:spoonacular/presentation/controller/recipe_controller.dart';
import 'package:spoonacular/presentation/controller/recipe_summary_controller.dart';
import 'package:spoonacular/presentation/controller/similar_recipes_controller.dart';
import 'package:spoonacular/presentation/view/details.dart';
import 'package:spoonacular/presentation/widget/ingredient_card.dart';

import '../recipe_mock_data.dart';
import 'recipes_controller_mock.dart';

void main() {
  group('Detail screen test', () {
    testWidgets(
        'view should have a list of ingredients, 2 html widgets(summary and nutritional value), and display a list of similar recipes',
        (tester) async {
      TestWidgetsFlutterBinding.ensureInitialized();
      Get.testMode = true;
      SimilarRecipesController similarRecipesController =
          MockSimilarRecipesController();
      RecipeController recipeController = MockRecipeController();
      NutritionalValueController nutritionalValueController =
          MockNutritionalValueController();
      IngredientsController ingredientsController = MockIngredientsController();

      RecipeSummaryController summaryController = RecipeSummaryController();
      Get.put(summaryController);

      Get.put(similarRecipesController);
      Get.put(recipeController);
      Get.put(nutritionalValueController);
      Get.put(ingredientsController);

      List<RecipeModel> listOfRecipes = [];
      RecipeMockData.responseData['recipes']!.forEach((recipe) {
        listOfRecipes.add(
          RecipeModel.fromJson(
            recipe,
          ),
        );
      });

      List<IngredientModel> listOfIngredients = [];
      RecipeMockData.ingredientsData['ingredients']?.forEach((ingredient) {
        listOfIngredients.add(
          IngredientModel.fromJson(
            ingredient,
          ),
        );
      });

      when(similarRecipesController.getSimilarRecipes(1)).thenAnswer((_) {
        (similarRecipesController as MockSimilarRecipesController)
            .setNewState(listOfRecipes, RxStatus.loading());
      });
      when(recipeController.getRecipeById(1)).thenAnswer((_) async {
        (recipeController as MockRecipeController)
            .setNewState(listOfRecipes[0], RxStatus.loading());
      });
      when(nutritionalValueController.getNutritionalValue(1))
          .thenAnswer((_) async {
        (nutritionalValueController as MockNutritionalValueController)
            .setNewState('nutritional value', RxStatus.loading());
      });
      when(ingredientsController.getListOfIngredients(1)).thenAnswer((_) {
        (ingredientsController as MockIngredientsController)
            .setNewState(listOfIngredients, RxStatus.loading());
      });

      await mockNetworkImagesFor(
        () async {
          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: Details(),
              ),
            ),
          );

          expect(
            find.byType(CircularProgressIndicator),
            findsWidgets,
          );

          when(similarRecipesController.getSimilarRecipes(1)).thenAnswer((_) {
            (similarRecipesController as MockSimilarRecipesController)
                .setNewState(listOfRecipes, RxStatus.success());
          });
          when(recipeController.getRecipeById(1)).thenAnswer((_) async {
            (recipeController as MockRecipeController)
                .setNewState(listOfRecipes[0], RxStatus.success());
          });
          when(nutritionalValueController.getNutritionalValue(1))
              .thenAnswer((_) async {
            (nutritionalValueController as MockNutritionalValueController)
                .setNewState('nutritional value', RxStatus.success());
          });
          when(ingredientsController.getListOfIngredients(1)).thenAnswer((_) {
            (ingredientsController as MockIngredientsController)
                .setNewState(listOfIngredients, RxStatus.success());
          });

          similarRecipesController.getSimilarRecipes(1);
          recipeController.getRecipeById(1);
          nutritionalValueController.getNutritionalValue(1);
          ingredientsController.getListOfIngredients(1);

          await tester.pumpAndSettle();

          expect(
            find.byType(Html),
            findsNWidgets(2),
          );

          expect(
            find.text('nutritional value'),
            findsOneWidget,
          );

          expect(
            find.byType(IngredientCard),
            findsNWidgets(listOfIngredients.length),
          );
        },
      );
    });
  });
}
