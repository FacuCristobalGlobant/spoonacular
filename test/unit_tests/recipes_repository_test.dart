import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:spoonacular/data/datasource/remote/api_service.dart';
import 'package:spoonacular/data/model/ingredient_model.dart';
import 'package:spoonacular/data/model/recipe_model.dart';
import 'package:spoonacular/data/repository/recipes_repository.dart';

import '../recipe_mock_data.dart';
import 'recipes_repository_test.mocks.dart';

@GenerateMocks([ApiService])
void main() {
  group('test spoonacular api responses', () {
    test(
      'fetch random recipes',
      () async {
        final ApiService apiService = MockApiService();
        when(apiService.getRandomRecipes(1)).thenAnswer((_) async {
          return dio.Response(
            requestOptions: dio.RequestOptions(
              path: 'spoonacularApi',
            ),
            statusCode: HttpStatus.ok,
            data: RecipeMockData.responseData,
          );
        });
        Get.put(apiService);
        final RecipesRepository repository = RecipesRepository();

        var result = await repository.getRandomRecipes(1);

        expect(
          result,
          isA<List<RecipeModel>>(),
        );
      },
    );
    test(
      'if api response status code is not 200, throw an exception',
      () async {
        final ApiService apiService = MockApiService();
        when(apiService.getRandomRecipes(1)).thenAnswer((_) async {
          return dio.Response(
            requestOptions: dio.RequestOptions(
              path: 'spoonacularApi',
            ),
            statusCode: HttpStatus.badRequest,
            data: RecipeMockData.responseData,
          );
        });
        Get.replace(apiService);
        final RecipesRepository repository = RecipesRepository();

        expect(
          repository.getRandomRecipes(1),
          throwsException,
        );
      },
    );
    test(
      'fetch the ingredients of a recipe',
      () async {
        final ApiService apiService = MockApiService();
        when(apiService.getListOfIngredients(1)).thenAnswer((_) async {
          return dio.Response(
            requestOptions: dio.RequestOptions(
              path: 'spoonacularApi',
            ),
            statusCode: HttpStatus.ok,
            data: RecipeMockData.ingredientsData,
          );
        });
        Get.replace(apiService);
        final RecipesRepository repository = RecipesRepository();

        var result = await repository.getRecipeIngredients(1);

        expect(
          result,
          isA<List<IngredientModel>>(),
        );
      },
    );
    test(
      'similar recipes',
      () async {
        final ApiService apiService = MockApiService();
        when(apiService.getSimilarRecipes(1)).thenAnswer((_) async {
          return dio.Response(
            requestOptions: dio.RequestOptions(
              path: 'spoonacularApi',
            ),
            statusCode: HttpStatus.ok,
            data: RecipeMockData.similarRecipesData,
          );
        });
        when(apiService.getRecipeById(1)).thenAnswer((_) async {
          return dio.Response(
            requestOptions: dio.RequestOptions(
              path: 'spoonacularApi',
            ),
            statusCode: HttpStatus.ok,
            data: RecipeMockData.singleRecipeData,
          );
        });
        Get.replace(apiService);
        final RecipesRepository repository = RecipesRepository();

        var result = await repository.getSimilarRecipes(1);

        expect(
          result,
          isA<List<RecipeModel>>(),
        );
      },
    );
    test(
      'fetch single recipe by id',
      () async {
        final ApiService apiService = MockApiService();
        when(apiService.getListOfIngredients(1)).thenAnswer((_) async {
          return dio.Response(
            requestOptions: dio.RequestOptions(
              path: 'spoonacularApi',
            ),
            statusCode: HttpStatus.ok,
            data: RecipeMockData.ingredientsData,
          );
        });
        Get.replace(apiService);
        final RecipesRepository repository = RecipesRepository();

        var result = await repository.getRecipeIngredients(1);

        expect(
          result,
          isA<List<IngredientModel>>(),
        );
      },
    );
    test(
      'fetch nutritional value of a recipe',
      () async {
        final ApiService apiService = MockApiService();
        when(apiService.getNutritionalValue(1)).thenAnswer((_) async {
          return dio.Response(
            requestOptions: dio.RequestOptions(
              path: 'spoonacularApi',
            ),
            statusCode: HttpStatus.ok,
            data: 'nutritional value',
          );
        });
        Get.replace(apiService);
        final RecipesRepository repository = RecipesRepository();

        var result = await repository.getNutritionalValue(1);

        expect(
          result,
          'nutritional value',
        );
      },
    );
  });
}
