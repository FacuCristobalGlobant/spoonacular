import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:spoonacular/data/model/recipe_model.dart';
import 'package:spoonacular/domain/usecase/implementations/get_random_recipes_usecase.dart';
import 'package:spoonacular/presentation/controller/recipes_controller.dart';

import '../recipe_mock_data.dart';
import 'recipes_controller_test.mocks.dart';

@GenerateMocks([GetRandomRecipesUseCase])
void main() {
  group('recipes controller tests', () {
    test(
        'listOfRecipes is initialized empty and emits new states when getRandomRecipes is called ',
        () async {
      final GetRandomRecipesUseCase useCase = MockGetRandomRecipesUseCase();
      Get.put(useCase);
      final RecipesController controller = RecipesController();
      when(useCase.call(params: 1)).thenAnswer((_) async {
        return [
          RecipeModel.fromJson(RecipeMockData.responseData['recipes']![0]),
        ];
      });

      expect(controller.listOfRecipes, hasLength(0));

      expect(
        controller.listOfRecipes.stream,
        emits(
          hasLength(1),
        ),
      );
      controller.getRandomRecipes(1);
    });
  });
}
