enum CuisineEnum {
  african('African'),
  american('American'),
  british('British'),
  cajun('Cajun'),
  caribbean('Caribbean'),
  chinese('Chinese'),
  easternEuropean('Eastern European'),
  european('European'),
  french('French'),
  german('German'),
  greek('Greek'),
  indian('Indian'),
  irish('Irish'),
  italian('Italian'),
  japanese('Japanese'),
  jewish('Jewish'),
  korean('Korean'),
  latinAmerican('Latin American'),
  mediterranean('Mediterranean'),
  mexican('Mexican'),
  middleEastern('Middle Eastern'),
  nordic('Nordic'),
  southern('Southern'),
  spanish('Spanish'),
  thai('Thai'),
  vietnamese('Vietnamese'),
  unsetted('Select cuisine');

  const CuisineEnum(
    this.propertyName,
  );

  final String propertyName;
}

enum MealTypeEnum {
  mainCourse('main course'),
  sideDish('side dish'),
  dessert('dessert'),
  appetizer('appetizer'),
  salad('salad'),
  bread('bread'),
  breakfast('breakfast'),
  soup('soup'),
  beverage('beverage'),
  sauce('sauce'),
  marinade('marinade'),
  fingerfood('fingerfood'),
  snack('snack'),
  drink('drink'),
  unsetted('Select meal type');

  const MealTypeEnum(
    this.propertyName,
  );

  final String propertyName;
}

enum SlidersEnum {
  maxCarbs(
    10,
    100,
  ),
  maxProtein(
    10,
    100,
  ),
  maxCalories(
    50,
    800,
  ),
  maxFat(
    1,
    100,
  ),
  maxCaffeine(
    0,
    100,
  ),
  maxCopper(
    0,
    100,
  ),
  maxCalcium(
    0,
    100,
  );

  const SlidersEnum(
    this.minValue,
    this.maxValue,
  );
  final double minValue;
  final double maxValue;
}
