import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:spoonacular/data/datasource/remote/api_service.dart';
import 'package:spoonacular/data/model/recipe_model.dart';
import 'package:spoonacular/data/repository/recipes_repository.dart';

import '../recipe_mock_data.dart';
import 'recipes_repository_test.mocks.dart';

@GenerateMocks([ApiService])
void main() {
  group('test spoonacular api responses', () {
    test('fetch random recipes', () async {
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

      expect(result, isA<List<RecipeModel>>());
    });
    test('if api response status code is not 200, throw an exception',
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
      Get.delete<ApiService>();
      Get.put(apiService);
      final RecipesRepository repository = RecipesRepository();

      expect(
        repository.getRandomRecipes(1),
        throwsException,
      );
    });
  });
}
