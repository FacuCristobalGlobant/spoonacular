import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:spoonacular/data/model/ingredient_model.dart';

import 'package:spoonacular/data/model/recipe_model.dart';
import 'package:spoonacular/presentation/controller/ingredients_controller.dart';
import 'package:spoonacular/presentation/controller/nutritional_value_controller.dart';
import 'package:spoonacular/presentation/controller/recipe_controller.dart';
import 'package:spoonacular/presentation/controller/recipes_controller.dart';
import 'package:spoonacular/presentation/controller/similar_recipes_controller.dart';

class MockRecipesController extends GetxController
    with Mock, StateMixin<List<RecipeModel>>
    implements RecipesController {
  void setNewState(List<RecipeModel>? value, RxStatus status) {
    change(value, status: status);
  }
}

class MockIngredientsController extends GetxController
    with Mock, StateMixin<List<IngredientModel>>
    implements IngredientsController {
  void setNewState(List<IngredientModel>? value, RxStatus status) {
    change(value, status: status);
  }
}

class MockNutritionalValueController extends GetxController
    with Mock, StateMixin<String>
    implements NutritionalValueController {
  void setNewState(String? value, RxStatus status) {
    change(value, status: status);
  }
}

class MockRecipeController extends GetxController
    with Mock, StateMixin<RecipeModel>
    implements RecipeController {
  void setNewState(RecipeModel? value, RxStatus status) {
    change(value, status: status);
  }
}

class MockSimilarRecipesController extends GetxController
    with Mock, StateMixin<List<RecipeModel>>
    implements SimilarRecipesController {
  void setNewState(List<RecipeModel>? value, RxStatus status) {
    change(value, status: status);
  }
}
