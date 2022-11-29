import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';

import '../../../data/repository/recipes_repository.dart';
import '../../repository/i_repository.dart';
import '../i_usecase.dart';

class GetNutritionalValueUseCase implements UseCase<String, int> {
  final IRepository _recipesRepository = Get.find<RecipesRepository>();

  @override
  Future<String> call({int? params}) async {
    return await _recipesRepository.getNutritionalValue(params!);
  }
}
