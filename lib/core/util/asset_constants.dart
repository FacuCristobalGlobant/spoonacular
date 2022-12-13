abstract class AssetConstants {
  static const String environmentVariables = '.env';
  static const String splashScreen = 'assets/splash_screen.json';
  static const String loadingAnimation = 'assets/loader.json';
  static const String companyLogo = 'assets/images/company-logo.svg';
  static const String sliverBackground = 'assets/images/background.webp';
  static const String searchIcon = 'assets/images/recipe_search_icon.png';
  static const String montserratFont = 'Montserrat';
  static const String nothingFont = 'NothingYouCouldDo';
  static const String timerIcon = 'assets/images/clock_icon.webp';
  static const String instagramIcon = 'assets/social/instagram.svg';
  static const String facebookIcon = 'assets/social/facebook.svg';
  static const String twitterIcon = 'assets/social/twitter.svg';
  static const String notFoundImage = 'assets/images/no_recipes_found.png';
  static const String likeIcon = 'assets/images/like_icon.png';
  static const String noImg = 'assets/images/no-img.webp';
  static const String menuImage = 'assets/images/menu-image.webp';
  static const String searchBackground = 'assets/images/search_bg.webp';
}

enum RecipeFlagsEnum {
  cheap(
    'assets/images/flags/cheap.svg',
    'Cheap',
    'cheap',
  ),
  dairyFree(
    'assets/images/flags/dairy-free.svg',
    'Dairy free',
    'dairyFree',
  ),
  glutenFree(
    'assets/images/flags/gluten-free.svg',
    'Gluten free',
    'glutenFree',
  ),
  healthy(
    'assets/images/flags/healthy.svg',
    'Healthy',
    'veryHealthy',
  ),
  lowFoodmap(
    'assets/images/flags/lowfm.svg',
    'Low Foodmap',
    'lowFodmap',
  ),
  popular(
    'assets/images/flags/popular.svg',
    'Popular',
    'veryPopular',
  ),
  sustainable(
    'assets/images/flags/sustainable.svg',
    'Sustainable',
    'sustainable',
  ),
  vegan(
    'assets/images/flags/vegan.svg',
    'Vegan',
    'vegan',
  ),
  vegetarian(
    'assets/images/flags/vegetarian.svg',
    'Vegetarian',
    'vegetarian',
  );

  const RecipeFlagsEnum(
    this.asset,
    this.tooltip,
    this.apiIdentifier,
  );
  final String asset;
  final String tooltip;
  final String apiIdentifier;
}
