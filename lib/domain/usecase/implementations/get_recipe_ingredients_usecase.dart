import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';

import '../../../data/model/ingredient_model.dart';
import '../../../data/repository/recipes_repository.dart';
import '../../repository/i_repository.dart';
import '../i_usecase.dart';

class GetRecipeIngredientsUseCase
    implements UseCase<List<IngredientModel>, int> {
  final IRepository _recipesRepository = Get.find<RecipesRepository>();

  @override
  Future<List<IngredientModel>> call({int? params}) async {
    return await _recipesRepository.getRecipeIngredients(params!);
  }
}
