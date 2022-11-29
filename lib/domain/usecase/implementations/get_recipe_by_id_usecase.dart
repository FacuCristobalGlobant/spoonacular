import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';

import '../../../data/model/recipe_model.dart';
import '../../../data/repository/recipes_repository.dart';
import '../../repository/i_repository.dart';
import '../i_usecase.dart';

class GetRecipeByIdUseCase implements UseCase<RecipeModel, int> {
  final IRepository _recipesRepository = Get.find<RecipesRepository>();

  @override
  Future<RecipeModel> call({int? params}) async {
    return await _recipesRepository.getRecipeById(params!);
  }
}
