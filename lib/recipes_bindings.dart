import 'package:dio/dio.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'presentation/controller/recipe_summary_controller.dart';
import 'presentation/controller/recipes_controller.dart';

import 'data/datasource/remote/api_service.dart';
import 'data/repository/recipes_repository.dart';
import 'domain/usecase/implementations/get_random_recipes_usecase.dart';

class RecipesBinding {
  void instantiateDependencies() {
    Get.lazyPut(() => ApiService());
    Get.lazyPut(() => RecipesRepository());
    Get.lazyPut(() => GetRandomRecipesUseCase());
    Get.lazyPut(() => RecipesController());
    Get.lazyPut(() => RecipeSummaryController());
    Get.lazyPut(() => Dio());
  }
}
