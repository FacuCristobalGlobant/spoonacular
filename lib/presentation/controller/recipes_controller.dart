import 'package:get/get.dart';

import '../../core/util/api_constants.dart';
import '../../data/model/recipe_model.dart';
import '../../domain/usecase/i_usecase.dart';
import '../../domain/usecase/implementations/get_random_recipes_usecase.dart';

class RecipesController extends GetxController
    with StateMixin<List<RecipeModel>> {
  final UseCase getRandomRecipesUseCase = Get.find<GetRandomRecipesUseCase>();

  RxList<RecipeModel> listOfRecipes = RxList<RecipeModel>();

  @override
  void onInit() {
    super.onInit();
    getRandomRecipes(ApiConstants.numberOfRandomRecipes);
  }

  void getRandomRecipes(int numberOfRecipes) async {
    listOfRecipes.clear();
    change(
      null,
      status: RxStatus.loading(),
    );
    try {
      listOfRecipes.addAll(
        await getRandomRecipesUseCase.call(
          params: numberOfRecipes,
        ),
      );
      listOfRecipes.isEmpty
          ? change(
              listOfRecipes,
              status: RxStatus.empty(),
            )
          : change(
              listOfRecipes,
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
