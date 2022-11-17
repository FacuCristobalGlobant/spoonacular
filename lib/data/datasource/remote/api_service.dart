import 'package:dio/dio.dart' as dio;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import '../../../core/util/api_constants.dart';

class ApiService {
  final dio.Dio client = Get.find<dio.Dio>();

  Future<dio.Response> getRandomRecipes(int numberOfResults) async {
    Map<String, dynamic> headers = {
      ApiConstants.headerKey: dotenv.env[ApiConstants.apiKeyParameterQuery],
    };
    final response = await client.get(
      '${ApiConstants.baseUrl}${ApiConstants.randomEndpoint}',
      queryParameters: {
        ApiConstants.numberQueryParameter: numberOfResults,
      },
      options: dio.Options(
        headers: headers,
      ),
    );
    return response;
  }
}
