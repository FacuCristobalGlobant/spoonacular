import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../core/util/api_constants.dart';
import '../../core/util/text_constants.dart';
import '../../domain/usecase/search_data_object.dart';
import '../datasource/remote/api_service.dart';
import '../model/ingredient_model.dart';
import '../model/recipe_model.dart';
import '../../domain/repository/i_repository.dart';

class RecipesRepository implements IRepository {
  static const String recipeIdField = 'id';

  final ApiService apiService = Get.find<ApiService>();

  @override
  Future<RecipeModel> getRecipeById(int id) async {
    try {
      final response = await apiService.getRecipeById(id);
      if (response.statusCode == HttpStatus.ok) {
        return RecipeModel.fromJson(response.data);
      } else {
        throw Exception(TextConstants.apiExceptionMessage);
      }
    } on DioError catch (e) {
      throw DioError(
        requestOptions: e.requestOptions,
      );
    }
  }

  @override
  Future<List<RecipeModel>> getSearchResults(
    SearchDataObject parameters,
  ) async {
    List<RecipeModel> listOfRecipes = [];
    try {
      final Map<String, dynamic> queryParameters = {
        ApiConstants.numberQueryParameter: ApiConstants.numberOfSearchResults,
        'cuisine': parameters.cuisine,
        'mealType': parameters.mealType,
        'maxCarbs': parameters.maxCarbs,
        'maxProtein': parameters.maxProtein,
        'maxCalories': parameters.maxCalories,
        'maxFat': parameters.maxFat,
        'maxCaffeine': parameters.maxCaffeine,
        'maxCopper': parameters.maxCopper,
        'maxCalcium': parameters.maxCalcium,
      };
      final response = await apiService.getSearchResult(
        queryParameters,
      );
      if (response.statusCode == HttpStatus.ok) {
        final List<dynamic> recipes = response.data['results'];
        for (var recipe in recipes) {
          RecipeModel currentRecipe = RecipeModel.fromJson(recipe);
          listOfRecipes.add(currentRecipe);
        }
      } else {
        throw Exception(TextConstants.apiExceptionMessage);
      }
    } on DioError catch (e) {
      throw DioError(
        requestOptions: e.requestOptions,
      );
    }
    return listOfRecipes;
  }

  @override
  Future<List<RecipeModel>> getSimilarRecipes(int id) async {
    List<RecipeModel> listOfRecipes = [];
    try {
      final response = await apiService.getSimilarRecipes(id);
      if (response.statusCode == HttpStatus.ok) {
        final List<dynamic> recipes = response.data;
        for (var recipe in recipes) {
          RecipeModel currentRecipe = RecipeModel.fromJson(recipe);
          listOfRecipes.add(currentRecipe);
        }
      } else {
        throw Exception(TextConstants.apiExceptionMessage);
      }
    } on DioError catch (e) {
      throw DioError(
        requestOptions: e.requestOptions,
      );
    }
    return listOfRecipes;
  }

  @override
  Future<String> getNutritionalValue(int id) async {
    try {
      final response = await apiService.getNutritionalValue(id);
      if (response.statusCode == HttpStatus.ok) {
        return response.data;
      } else {
        throw Exception(TextConstants.apiExceptionMessage);
      }
    } on DioError catch (e) {
      throw DioError(
        requestOptions: e.requestOptions,
      );
    }
  }

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
    } on DioError catch (e) {
      throw DioError(
        requestOptions: e.requestOptions,
      );
    }
    return listOfRecipes;
  }

  @override
  Future<List<IngredientModel>> getRecipeIngredients(int id) async {
    List<IngredientModel> listOfIngredients = [];
    try {
      final response = await apiService.getListOfIngredients(id);
      if (response.statusCode == HttpStatus.ok) {
        final ingredients = (response
                .data[ApiConstants.apiResponseIngredientsData] as List)
            .map((ingredientJson) => IngredientModel.fromJson(ingredientJson))
            .toList();
        listOfIngredients.addAll(ingredients);
      } else {
        throw Exception(TextConstants.apiExceptionMessage);
      }
    } on DioError catch (e) {
      throw DioError(
        requestOptions: e.requestOptions,
      );
    }
    return listOfIngredients;
  }
}
