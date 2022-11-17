import 'package:get/get.dart';
import 'package:mockito/mockito.dart';

import 'package:spoonacular/data/model/recipe_model.dart';
import 'package:spoonacular/presentation/controller/recipes_controller.dart';

class MockRecipesController extends GetxController
    with Mock, StateMixin<List<RecipeModel>>
    implements RecipesController {
  void setNewState(List<RecipeModel>? value, RxStatus status) {
    change(value, status: status);
  }
}
