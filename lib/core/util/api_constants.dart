abstract class ApiConstants {
  static const String apiKeyParameterQuery = 'API_KEY';
  static const String apiKey = 'a6380c276b474fb48bd6159ffe38deba';
  static const String baseUrl = 'https://api.spoonacular.com/';
  static const String imageBase =
      'https://spoonacular.com/cdn/ingredients_250x250/';
  static const String recipeImageBase = 'https://spoonacular.com/recipeImages/';
  static const String recipeImageResolution = '-556x370.jpg';
  static const String recipesEndpoint = 'recipes/';
  static const String randomEndpoint = 'random/';
  static const String infoEndpoint = 'information/';
  static const String ingredientsEndpoint = 'ingredientWidget.json';
  static const String nutritionalValueEndpoint = 'nutritionLabel';
  static const String similarRecipesEndpoint = 'similar';
  static const String searchEndpoint = 'complexSearch';
  static const String headerKey = 'x-api-key';
  static const String queryParamKey = 'apiKey';
  static const String numberQueryParameter = 'number';
  static const String apiResponseRecipesData = 'recipes';
  static const String apiResponseIngredientsData = 'ingredients';
  static const int numberOfRandomRecipes = 10;
  static const int numberOfSimilarRecipes = 5;
  static const int numberOfSearchResults = 6;
}
