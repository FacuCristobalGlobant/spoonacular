import 'package:dio/dio.dart' as dio;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import '../../../core/util/api_constants.dart';

class ApiService {
  static Map<String, dynamic> headers = {
    ApiConstants.headerKey: dotenv.env[ApiConstants.apiKeyParameterQuery],
  };
  final dio.Dio client = Get.find<dio.Dio>();
  Future<dio.Response> getRandomRecipes(int numberOfResults) async {
    final response = await client.get(
      '${ApiConstants.recipesEndpoint}${ApiConstants.randomEndpoint}',
      queryParameters: {
        ApiConstants.numberQueryParameter: numberOfResults,
      },
      options: dio.Options(
        headers: headers,
      ),
    );
    return response;
  }

  Future<dio.Response> getSimilarRecipes(int id) async {
    final response = await client.get(
      '${ApiConstants.recipesEndpoint}$id/${ApiConstants.similarRecipesEndpoint}',
      options: dio.Options(
        headers: headers,
      ),
      queryParameters: {
        ApiConstants.numberQueryParameter: ApiConstants.numberOfSimilarRecipes,
      },
    );
    return response;
  }

  Future<dio.Response> getRecipeById(int id) async {
    final response = await client.get(
      '${ApiConstants.recipesEndpoint}$id/${ApiConstants.infoEndpoint}',
      options: dio.Options(
        headers: headers,
      ),
    );
    return response;
  }

  Future<dio.Response> getListOfIngredients(int id) async {
    final response = await client.get(
      '${ApiConstants.recipesEndpoint}$id/${ApiConstants.ingredientsEndpoint}',
      options: dio.Options(
        headers: headers,
      ),
    );
    return response;
  }

  Future<dio.Response> getNutritionalValue(int id) async {
    final response = await client.get(
      '${ApiConstants.recipesEndpoint}$id/${ApiConstants.nutritionalValueEndpoint}',
      options: dio.Options(
        headers: headers,
      ),
    );
    return response;
  }
}
