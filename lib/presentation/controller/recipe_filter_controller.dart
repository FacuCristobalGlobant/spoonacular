import 'package:get/get.dart';

import '../../core/util/filter_enums.dart';
import '../../domain/usecase/search_data_object.dart';

class RecipeFilterController extends GetxController {
  final Rx<CuisineEnum> cuisine = CuisineEnum.unsetted.obs;
  final Rx<MealTypeEnum> mealType = MealTypeEnum.unsetted.obs;
  final Rx<double> maxCarbs = SlidersEnum.maxCarbs.minValue.obs;
  final Rx<double> maxProtein = SlidersEnum.maxProtein.minValue.obs;
  final Rx<double> maxCalories = SlidersEnum.maxCalories.minValue.obs;
  final Rx<double> maxFat = SlidersEnum.maxFat.minValue.obs;
  final Rx<double> maxCaffeine = SlidersEnum.maxCaffeine.minValue.obs;
  final Rx<double> maxCopper = SlidersEnum.maxCopper.minValue.obs;
  final Rx<double> maxCalcium = SlidersEnum.maxCalcium.minValue.obs;

  bool hasValidSearch() {
    return (cuisine.value != CuisineEnum.unsetted &&
        mealType.value != MealTypeEnum.unsetted);
  }

  SearchDataObject searchParams() {
    return SearchDataObject(
      cuisine.value.propertyName,
      mealType.value.propertyName,
      maxCarbs.value.toInt(),
      maxProtein.value.toInt(),
      maxCalories.value.toInt(),
      maxFat.value.toInt(),
      maxCaffeine.value.toInt(),
      maxCopper.value.toInt(),
      maxCalcium.value.toInt(),
    );
  }

  void resetFilters() {
    cuisine(CuisineEnum.unsetted);
    mealType(MealTypeEnum.unsetted);
    maxCarbs(SlidersEnum.maxCarbs.minValue);
    maxProtein(SlidersEnum.maxProtein.minValue);
    maxCalories(SlidersEnum.maxCalories.minValue);
    maxFat(SlidersEnum.maxFat.minValue);
    maxCaffeine(SlidersEnum.maxCaffeine.minValue);
    maxCopper(SlidersEnum.maxCopper.minValue);
    maxCalcium(SlidersEnum.maxCalcium.minValue);
  }
}
