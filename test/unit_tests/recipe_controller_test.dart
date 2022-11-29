import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:spoonacular/data/model/recipe_model.dart';
import 'package:spoonacular/domain/usecase/implementations/get_recipe_by_id_usecase.dart';

import 'package:spoonacular/presentation/controller/recipe_controller.dart';

import '../recipe_mock_data.dart';
import 'recipe_controller_test.mocks.dart';

@GenerateMocks([GetRecipeByIdUseCase])
void main() {
  group('recipe controller tests', () {
    test('Fetch a single recipe from the API', () async {
      final GetRecipeByIdUseCase useCase = MockGetRecipeByIdUseCase();
      Get.put(useCase);
      final RecipeController controller = RecipeController();
      when(useCase.call(params: 1)).thenAnswer((_) async {
        return RecipeModel.fromJson(RecipeMockData.singleRecipeData);
      });

      expect(
        controller.state,
        null,
      );
      await controller.getRecipeById(1);
      expect(
        controller.state,
        isA<RecipeModel>(),
      );
    });
  });
}
