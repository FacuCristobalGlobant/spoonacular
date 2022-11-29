import 'package:get/get.dart';

import '../../data/model/ingredient_model.dart';
import '../../domain/usecase/i_usecase.dart';
import '../../domain/usecase/implementations/get_recipe_ingredients_usecase.dart';

class IngredientsController extends GetxController
    with StateMixin<List<IngredientModel>> {
  final UseCase getRecipeIngredients = Get.find<GetRecipeIngredientsUseCase>();

  RxList<IngredientModel> listOfIngredients = RxList<IngredientModel>();

  int? recipeId;

  @override
  void onReady() {
    if (recipeId == null) {
      getListOfIngredients(
        int.parse(Get.parameters['id']!),
      );
    }
  }

  void getListOfIngredients(int? id) async {
    recipeId = id;
    listOfIngredients.clear();
    change(
      null,
      status: RxStatus.loading(),
    );

    try {
      listOfIngredients.addAll(await getRecipeIngredients(params: recipeId));

      change(
        listOfIngredients,
        status:
            listOfIngredients.isEmpty ? RxStatus.empty() : RxStatus.success(),
      );
    } catch (e) {
      change(
        null,
        status: RxStatus.error(e.toString()),
      );
    }
  }
}
