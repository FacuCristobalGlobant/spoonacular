import 'package:dio/dio.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'domain/usecase/implementations/get_search_results_usecase.dart';
import 'presentation/controller/search_results_controller.dart';
import 'presentation/controller/recipe_filter_controller.dart';
import 'core/util/api_constants.dart';
import 'presentation/controller/similar_recipes_controller.dart';
import 'domain/usecase/implementations/get_similar_recipes_usecase.dart';
import 'presentation/controller/nutritional_value_controller.dart';
import 'domain/usecase/implementations/get_nutritional_value_usecase.dart';
import 'domain/usecase/implementations/get_recipe_ingredients_usecase.dart';
import 'presentation/controller/ingredients_controller.dart';
import 'presentation/controller/recipe_controller.dart';
import 'domain/usecase/implementations/get_recipe_by_id_usecase.dart';
import 'presentation/controller/recipe_summary_controller.dart';
import 'presentation/controller/recipes_controller.dart';

import 'data/datasource/remote/api_service.dart';
import 'data/repository/recipes_repository.dart';
import 'domain/usecase/implementations/get_random_recipes_usecase.dart';

class RecipesBinding {
  void instantiateDependencies() {
    Get.lazyPut(
      () => ApiService(),
      fenix: true,
    );
    Get.lazyPut(
      () => RecipesRepository(),
      fenix: true,
    );
    Get.lazyPut(
      () => GetRandomRecipesUseCase(),
      fenix: true,
    );
    Get.lazyPut(
      () => RecipesController(),
      fenix: true,
    );
    Get.lazyPut(
      () => RecipeController(),
      fenix: true,
    );
    Get.lazyPut(
      () => RecipeSummaryController(),
      fenix: true,
    );
    Get.lazyPut(
      () => Dio(
        BaseOptions(
          baseUrl: ApiConstants.baseUrl,
        ),
      ),
      fenix: true,
    );
    Get.lazyPut(
      () => GetRecipeByIdUseCase(),
      fenix: true,
    );
    Get.lazyPut(
      () => IngredientsController(),
      fenix: true,
    );
    Get.lazyPut(
      () => GetRecipeIngredientsUseCase(),
      fenix: true,
    );
    Get.lazyPut(
      () => GetNutritionalValueUseCase(),
      fenix: true,
    );
    Get.lazyPut(
      () => NutritionalValueController(),
      fenix: true,
    );
    Get.lazyPut(
      () => GetSimilarRecipesUseCase(),
      fenix: true,
    );
    Get.lazyPut(
      () => SimilarRecipesController(),
      fenix: true,
    );
    Get.lazyPut(
      () => RecipeFilterController(),
      fenix: true,
    );
    Get.lazyPut(
      () => SearchResultsController(),
      fenix: true,
    );
    Get.lazyPut(
      () => GetSearchResultsUseCase(),
      fenix: true,
    );
  }
}
