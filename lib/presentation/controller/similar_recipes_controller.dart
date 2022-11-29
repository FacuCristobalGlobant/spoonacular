import 'package:get/get.dart';

import '../../data/model/recipe_model.dart';
import '../../domain/usecase/i_usecase.dart';
import '../../domain/usecase/implementations/get_similar_recipes_usecase.dart';

class SimilarRecipesController extends GetxController
    with StateMixin<List<RecipeModel>> {
  final UseCase getSimilarRecipesUseCase = Get.find<GetSimilarRecipesUseCase>();

  RxList<RecipeModel> listOfRecipes = RxList<RecipeModel>();

  int? recipeId;

  @override
  void onReady() {
    if (recipeId == null) {
      getSimilarRecipes(
        int.parse(Get.parameters['id']!),
      );
    }
  }

  void getSimilarRecipes(int? id) async {
    recipeId = id;

    listOfRecipes.clear();
    change(
      null,
      status: RxStatus.loading(),
    );
    try {
      listOfRecipes.addAll(
        await getSimilarRecipesUseCase.call(
          params: recipeId,
        ),
      );

      change(
        listOfRecipes,
        status: listOfRecipes.isEmpty ? RxStatus.empty() : RxStatus.success(),
      );
    } catch (e) {
      change(
        null,
        status: RxStatus.error(e.toString()),
      );
    }
  }
}
