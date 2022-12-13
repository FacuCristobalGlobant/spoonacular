import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:spoonacular/core/util/filter_enums.dart';

import 'package:spoonacular/data/model/recipe_model.dart';
import 'package:spoonacular/domain/usecase/implementations/get_search_results_usecase.dart';
import 'package:spoonacular/domain/usecase/search_data_object.dart';
import 'package:spoonacular/presentation/controller/search_results_controller.dart';

import '../recipe_mock_data.dart';
import 'search_results_controller_test.mocks.dart';

@GenerateMocks([GetSearchResultsUseCase])
void main() {
  group('search controller test', () {
    test('', () async {
      final GetSearchResultsUseCase useCase = MockGetSearchResultsUseCase();
      Get.put(useCase);
      final SearchResultsController controller = SearchResultsController();
      SearchDataObject filter = SearchDataObject(
        CuisineEnum.african.toString(),
        MealTypeEnum.salad.toString(),
        10,
        10,
        10,
        10,
        10,
        10,
        10,
      );
      when(useCase.call(params: filter)).thenAnswer((_) async {
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
      controller.getSearchResults(filter);
    });
  });
}
