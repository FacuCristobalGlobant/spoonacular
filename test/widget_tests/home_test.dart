import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:spoonacular/core/util/api_constants.dart';
import 'package:spoonacular/core/util/keys.dart';
import 'package:spoonacular/data/model/recipe_model.dart';
import 'package:spoonacular/presentation/controller/recipe_summary_controller.dart';
import 'package:spoonacular/presentation/controller/recipes_controller.dart';
import 'package:spoonacular/presentation/view/home.dart';
import 'package:spoonacular/presentation/widget/recipe_card_vertical.dart';

import '../recipe_mock_data.dart';
import 'recipes_controller_mock.dart';

void main() {
  group('Home screen test', () {
    testWidgets('', (tester) async {
      RecipesController controller = MockRecipesController();
      RecipeSummaryController summaryController = RecipeSummaryController();
      Get.put(controller);
      Get.put(summaryController);

      when(controller.getRandomRecipes(ApiConstants.numberOfRandomRecipes))
          .thenAnswer((realInvocation) {
        (controller as MockRecipesController)
            .setNewState(null, RxStatus.loading());
      });

      await mockNetworkImagesFor(
        () async {
          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: Home(),
              ),
            ),
          );

          expect(
            find.byType(CircularProgressIndicator),
            findsOneWidget,
          );

          when(controller.getRandomRecipes(ApiConstants.numberOfRandomRecipes))
              .thenAnswer((realInvocation) {
            (controller as MockRecipesController).setNewState(
              [
                RecipeModel.fromJson(RecipeMockData.responseData['recipes']![0])
              ],
              RxStatus.success(),
            );
          });

          await tester.tap(find.byKey(Keys.refreshRecipes));

          await tester.pumpAndSettle();

          expect(
            find.byType(RecipeCardVertical),
            findsOneWidget,
          );

          when(controller.getRandomRecipes(ApiConstants.numberOfRandomRecipes))
              .thenAnswer((realInvocation) {
            (controller as MockRecipesController).setNewState(
              [
                RecipeModel.fromJson(RecipeMockData.responseData['recipes']![0])
              ],
              RxStatus.error('errorMessage'),
            );
          });
          await tester.tap(find.byKey(Keys.refreshRecipes));

          await tester.pumpAndSettle();

          expect(
            find.text('errorMessage'),
            findsOneWidget,
          );
        },
      );
    });
  });
}
