import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';

import '../../../core/util/api_constants.dart';

class ApiService {
  final dio.Dio client = Get.find<dio.Dio>();
  Future<dio.Response> getRandomRecipes(int numberOfResults) async {
    final response = await client.get(
      '${ApiConstants.recipesEndpoint}${ApiConstants.randomEndpoint}',
      queryParameters: {
        ApiConstants.numberQueryParameter: numberOfResults,
        ApiConstants.queryParamKey: ApiConstants.apiKey,
      },
    );
    return response;
  }

  Future<dio.Response> getSimilarRecipes(int id) async {
    final response = await client.get(
      '${ApiConstants.recipesEndpoint}$id/${ApiConstants.similarRecipesEndpoint}',
      queryParameters: {
        ApiConstants.numberQueryParameter: ApiConstants.numberOfSimilarRecipes,
        ApiConstants.queryParamKey: ApiConstants.apiKey,
      },
    );
    return response;
  }

  Future<dio.Response> getSearchResult(
    Map<String, dynamic> queryParameters,
  ) async {
    queryParameters[ApiConstants.queryParamKey] = ApiConstants.apiKey;
    final response = await client.get(
      '${ApiConstants.recipesEndpoint}${ApiConstants.searchEndpoint}',
      queryParameters: queryParameters,
    );
    return response;
  }

  Future<dio.Response> getRecipeById(int id) async {
    final response = await client.get(
      '${ApiConstants.recipesEndpoint}$id/${ApiConstants.infoEndpoint}',
      queryParameters: {
        ApiConstants.queryParamKey: ApiConstants.apiKey,
      },
    );
    return response;
  }

  Future<dio.Response> getListOfIngredients(int id) async {
    final response = await client.get(
      '${ApiConstants.recipesEndpoint}$id/${ApiConstants.ingredientsEndpoint}',
      queryParameters: {
        ApiConstants.queryParamKey: ApiConstants.apiKey,
      },
    );
    return response;
  }

  Future<dio.Response> getNutritionalValue(int id) async {
    final response = await client.get(
      '${ApiConstants.recipesEndpoint}$id/${ApiConstants.nutritionalValueEndpoint}',
      queryParameters: {
        ApiConstants.queryParamKey: ApiConstants.apiKey,
      },
    );
    return response;
  }
}
