import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';

import '../../../data/model/recipe_model.dart';
import '../../../data/repository/recipes_repository.dart';
import '../../repository/i_repository.dart';
import '../i_usecase.dart';
import '../search_data_object.dart';

class GetSearchResultsUseCase
    implements UseCase<List<RecipeModel>, SearchDataObject> {
  final IRepository _recipesRepository = Get.find<RecipesRepository>();

  @override
  Future<List<RecipeModel>> call({SearchDataObject? params}) async {
    return await _recipesRepository.getSearchResults(params!);
  }
}
