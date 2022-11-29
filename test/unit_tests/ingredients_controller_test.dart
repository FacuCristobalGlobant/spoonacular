import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:spoonacular/data/model/ingredient_model.dart';

import 'package:spoonacular/domain/usecase/implementations/get_recipe_ingredients_usecase.dart';
import 'package:spoonacular/presentation/controller/ingredients_controller.dart';

import '../recipe_mock_data.dart';
import 'ingredients_controller_test.mocks.dart';

@GenerateMocks([GetRecipeIngredientsUseCase])
void main() {
  group('ingredients controller tests', () {
    test(
        'listOfIngredients is initialized empty and emits new states when getRecipeIngredients is called ',
        () async {
      final GetRecipeIngredientsUseCase useCase =
          MockGetRecipeIngredientsUseCase();
      Get.put(useCase);
      final IngredientsController controller = IngredientsController();
      when(useCase.call(params: 1)).thenAnswer((_) async {
        return [
          IngredientModel.fromJson(
            RecipeMockData.ingredientsData['ingredients']![0],
          ),
        ];
      });

      expect(controller.listOfIngredients, hasLength(0));

      expect(
        controller.listOfIngredients.stream,
        emits(
          hasLength(1),
        ),
      );
      controller.getListOfIngredients(1);
    });
  });
}
