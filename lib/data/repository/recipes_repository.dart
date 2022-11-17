import 'dart:io';

import 'package:get/get.dart';

import '../../core/util/api_constants.dart';
import '../../core/util/text_constants.dart';
import '../datasource/remote/api_service.dart';
import '../model/recipe_model.dart';
import '../../domain/repository/i_repository.dart';

class RecipesRepository implements IRepository {
  final ApiService apiService = Get.find<ApiService>();

  @override
  Future<List<RecipeModel>> getRandomRecipes(int numberOfResults) async {
    List<RecipeModel> listOfRecipes = [];
    try {
      final response = await apiService.getRandomRecipes(numberOfResults);
      if (response.statusCode == HttpStatus.ok) {
        final recipes =
            (response.data[ApiConstants.apiResponseRecipesData] as List)
                .map((recipeJson) => RecipeModel.fromJson(recipeJson))
                .toList();
        listOfRecipes.addAll(recipes);
      } else {
        throw Exception(TextConstants.apiExceptionMessage);
      }
    } catch (e) {
      throw Exception(e);
    }
    return listOfRecipes;
  }
}
