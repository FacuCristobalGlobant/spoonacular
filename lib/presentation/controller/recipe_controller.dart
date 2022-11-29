import 'package:get/get.dart';

import '../../data/model/recipe_model.dart';
import '../../domain/usecase/i_usecase.dart';
import '../../domain/usecase/implementations/get_recipe_by_id_usecase.dart';

class RecipeController extends GetxController with StateMixin<RecipeModel> {
  final UseCase getRecipeByIdUseCase = Get.find<GetRecipeByIdUseCase>();

  int? recipeId;

  @override
  void onReady() {
    if (recipeId == null) {
      getRecipeById(
        int.parse(Get.parameters['id']!),
      );
    }
  }

  Future<void>? getRecipeById(int? id) async {
    recipeId = id;
    change(
      null,
      status: RxStatus.loading(),
    );

    try {
      RecipeModel recipe = await getRecipeByIdUseCase(params: recipeId);
      change(
        recipe,
        status: RxStatus.success(),
      );
    } catch (e) {
      change(
        null,
        status: RxStatus.error(e.toString()),
      );
    }
  }
}
