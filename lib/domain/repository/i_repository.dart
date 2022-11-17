import '../../data/model/recipe_model.dart';

abstract class IRepository {
  Future<List<RecipeModel>> getRandomRecipes(int numberOfResults);
}
