import '../../data/model/ingredient_model.dart';
import '../../data/model/recipe_model.dart';

abstract class IRepository {
  Future<List<RecipeModel>> getRandomRecipes(int numberOfResults);
  Future<List<RecipeModel>> getSimilarRecipes(int id);
  Future<RecipeModel> getRecipeById(int id);
  Future<List<IngredientModel>> getRecipeIngredients(int id);
  Future<String> getNutritionalValue(int id);
}
