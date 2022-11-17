import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mockito/mockito.dart';
import 'package:spoonacular/core/util/api_constants.dart';
import 'package:spoonacular/presentation/controller/recipe_summary_controller.dart';
import 'package:spoonacular/presentation/controller/recipes_controller.dart';
import 'package:spoonacular/presentation/view/splash_screen.dart';

import 'recipes_controller_mock.dart';

void main() {
  group('splash screen', () {
    testWidgets('a Lottie animation should appear when the application starts',
        (tester) async {
      RecipesController controller = MockRecipesController();
      RecipeSummaryController summaryController = RecipeSummaryController();
      Get.put(controller);
      Get.put(summaryController);

      when(controller.getRandomRecipes(ApiConstants.numberOfRandomRecipes))
          .thenAnswer((realInvocation) {
        (controller as MockRecipesController).setNewState(
          null,
          RxStatus.loading(),
        );
      });
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SplashScreen(),
          ),
        ),
      );

      expect(
        find.byType(Lottie),
        findsOneWidget,
      );
    });
  });
}
