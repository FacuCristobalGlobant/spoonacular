import 'package:flutter_test/flutter_test.dart';
import 'package:spoonacular/core/util/filter_enums.dart';

import 'package:spoonacular/presentation/controller/recipe_filter_controller.dart';

void main() {
  group('recipe filter controller tests', () {
    test('', () async {
      final RecipeFilterController controller = RecipeFilterController();

      expect(
        controller.cuisine.value,
        CuisineEnum.unsetted,
      );
      controller.cuisine(CuisineEnum.easternEuropean);
      expect(
        controller.cuisine.value,
        CuisineEnum.easternEuropean,
      );
      expect(
        controller.hasValidSearch(),
        false,
      );
      controller.mealType(MealTypeEnum.salad);
      expect(
        controller.hasValidSearch(),
        true,
      );
    });
  });
}
