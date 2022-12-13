import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../core/util/asset_constants.dart';
import '../../core/util/dimensions.dart';
import '../../core/util/filter_enums.dart';
import '../../core/util/palette.dart';
import '../controller/recipe_filter_controller.dart';
import '../controller/search_results_controller.dart';
import '../widget/company_logo.dart';

import '../widget/dropdown_filter.dart';
import '../widget/footer.dart';
import '../widget/no_search_results.dart';
import '../widget/recipe_grid_widget.dart';
import '../widget/slider_filter.dart';

class Search extends StatelessWidget {
  static const double logoSize = 200;
  static const double footerHeight = 110;
  static const double menuCloseIconSize = 15;
  static const String cancelButtonText = 'Cancel';
  static const String searchButtonText = 'Search';
  static const String menuTitle = 'Filter Recipes';
  static const String cuisineTitle = 'Cuisine';
  static const String mealTypeTitle = 'Meal type';
  static const String maxCarbsTitle = 'Max Carbs';
  static const String maxProteinTitle = 'Max Protein';
  static const String maxCaloriesTitle = 'Max Calories';
  static const String maxFatTitle = 'Max Fat';
  static const String maxCaffeineTitle = 'Max Caffeine';
  static const String maxCopperTitle = 'Max Copper';
  static const String maxCalciumTitle = 'Max Calcium';
  static const String successMessage =
      'Your search yielded the following results';
  static const EdgeInsets successMessagePadding = EdgeInsets.only(
    top: 50,
    bottom: 20,
  );
  static const String instructionsTitle =
      'Find recipes that fit your preferences';

  static const List<String> listOfInstructions = [
    '1 - Open the menu to see the filter options',
    '2 -Tweak the filters to fit your preferences',
    '3 - Once you are done click the Search button'
  ];

  final RecipeFilterController filterController =
      Get.find<RecipeFilterController>();

  final SearchResultsController searchResultsController =
      Get.find<SearchResultsController>();

  Search({Key? key}) : super(key: key);

  Widget _singleInstruction(text) {
    return Padding(
      padding: Dimensions.smallTopPadding,
      child: Text(
        text,
        overflow: TextOverflow.fade,
        style: const TextStyle(
          fontSize: Dimensions.mediumFontSize,
          fontFamily: AssetConstants.nothingFont,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _instructions() {
    return Center(
      child: Stack(
        children: [
          Image.asset(
            AssetConstants.searchBackground,
            fit: BoxFit.cover,
            width: Get.width,
            height: Get.height,
          ),
          Container(
            width: Get.width,
            height: Get.height,
            color: Palette.darkOverlay,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  instructionsTitle,
                  style: TextStyle(
                    fontSize: Dimensions.bigFontSize,
                    color: Colors.white,
                    fontFamily: AssetConstants.nothingFont,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: listOfInstructions
                      .map((instruction) => _singleInstruction(instruction))
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        bottomNavigationBar: const SizedBox(
          height: footerHeight,
          child: Footer(),
        ),
        appBar: AppBar(
          backgroundColor: Palette.primary,
          title: const CompanyLogo(),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Get.width * Dimensions.fivePercent,
              ),
              child: Image.asset(
                AssetConstants.searchIcon,
                width: Dimensions.searchIconWidth,
                color: Colors.white,
                filterQuality: FilterQuality.medium,
              ),
            ),
          ],
        ),
        drawer: Drawer(
          child: Scrollbar(
            thumbVisibility: true,
            child: ListView(
              dragStartBehavior: DragStartBehavior.down,
              children: [
                DrawerHeader(
                  padding: EdgeInsets.zero,
                  decoration: const BoxDecoration(
                    color: Palette.greyBackground,
                  ),
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Image.asset(
                        AssetConstants.menuImage,
                        fit: BoxFit.cover,
                        width: Get.width,
                      ),
                      Container(
                        width: Get.width,
                        height: Get.height,
                        color: Palette.darkOverlay,
                      ),
                      const Text(
                        menuTitle,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: AssetConstants.nothingFont,
                          fontSize: Dimensions.bigFontSize,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      Positioned(
                        top: menuCloseIconSize,
                        left: menuCloseIconSize,
                        child: GestureDetector(
                          onTap: () {
                            searchResultsController.resetSearchResults();
                            filterController.resetFilters();
                            Get.back();
                          },
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                DropDownFilter(
                  value: filterController.cuisine.value.propertyName,
                  title: cuisineTitle,
                  onChanged: (value) {
                    filterController.cuisine(
                      CuisineEnum.values.firstWhere(
                        (e) => e.propertyName == value,
                      ),
                    );
                  },
                  validValues: CuisineEnum.values
                      .map(
                        (cuisine) => DropdownMenuItem<String>(
                          value: cuisine.propertyName,
                          child: Text(cuisine.propertyName),
                        ),
                      )
                      .toList(),
                ),
                DropDownFilter(
                  value: filterController.mealType.value.propertyName,
                  title: mealTypeTitle,
                  onChanged: (value) {
                    filterController.mealType(
                      MealTypeEnum.values.firstWhere(
                        (e) => e.propertyName == value,
                      ),
                    );
                  },
                  validValues: MealTypeEnum.values
                      .map(
                        (mealType) => DropdownMenuItem<String>(
                          value: mealType.propertyName,
                          child: Text(mealType.propertyName),
                        ),
                      )
                      .toList(),
                ),
                SliderFilter(
                  minValue: SlidersEnum.maxCarbs.minValue,
                  title: maxCarbsTitle,
                  maxValue: SlidersEnum.maxCarbs.maxValue,
                  currentValue: filterController.maxCarbs.value,
                  onChanged: (value) {
                    filterController.maxCarbs(
                      value.floorToDouble(),
                    );
                  },
                  trailing: filterController.maxCarbs.value.toString(),
                ),
                SliderFilter(
                  minValue: SlidersEnum.maxProtein.minValue,
                  title: maxProteinTitle,
                  maxValue: SlidersEnum.maxProtein.maxValue,
                  currentValue: filterController.maxProtein.value,
                  onChanged: (value) {
                    filterController.maxProtein(
                      value.floorToDouble(),
                    );
                  },
                  trailing: filterController.maxProtein.value.toString(),
                ),
                SliderFilter(
                  minValue: SlidersEnum.maxCalories.minValue,
                  title: maxCaloriesTitle,
                  maxValue: SlidersEnum.maxCalories.maxValue,
                  currentValue: filterController.maxCalories.value,
                  onChanged: (value) {
                    filterController.maxCalories(
                      value.floorToDouble(),
                    );
                  },
                  trailing: filterController.maxCalories.value.toString(),
                ),
                SliderFilter(
                  minValue: SlidersEnum.maxFat.minValue,
                  title: maxFatTitle,
                  maxValue: SlidersEnum.maxFat.maxValue,
                  currentValue: filterController.maxFat.value,
                  onChanged: (value) {
                    filterController.maxFat(
                      value.floorToDouble(),
                    );
                  },
                  trailing: filterController.maxFat.value.toString(),
                ),
                SliderFilter(
                  minValue: SlidersEnum.maxCaffeine.minValue,
                  title: maxCaffeineTitle,
                  maxValue: SlidersEnum.maxCaffeine.maxValue,
                  currentValue: filterController.maxCaffeine.value,
                  onChanged: (value) {
                    filterController.maxCaffeine(
                      value.floorToDouble(),
                    );
                  },
                  trailing: filterController.maxCaffeine.value.toString(),
                ),
                SliderFilter(
                  minValue: SlidersEnum.maxCopper.minValue,
                  title: maxCopperTitle,
                  maxValue: SlidersEnum.maxCopper.maxValue,
                  currentValue: filterController.maxCopper.value,
                  onChanged: (value) {
                    filterController.maxCopper(
                      value.floorToDouble(),
                    );
                  },
                  trailing: filterController.maxCopper.value.toString(),
                ),
                SliderFilter(
                  minValue: SlidersEnum.maxCalcium.minValue,
                  title: maxCalciumTitle,
                  maxValue: SlidersEnum.maxCalcium.maxValue,
                  currentValue: filterController.maxCalcium.value,
                  onChanged: (value) {
                    filterController.maxCalcium(
                      value.floorToDouble(),
                    );
                  },
                  trailing: filterController.maxCalcium.value.toString(),
                ),
                ListTile(
                  title: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            searchResultsController.resetSearchResults();
                            filterController.resetFilters();
                          },
                          child: Container(
                            padding: Dimensions.smallPadding,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(Dimensions.cardRadius),
                              ),
                              border: Border.all(color: Colors.red),
                            ),
                            child: const Text(
                              cancelButtonText,
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (filterController.hasValidSearch()) {
                              searchResultsController.getSearchResults(
                                filterController.searchParams(),
                              );
                            }
                          },
                          child: Container(
                            padding: Dimensions.smallPadding,
                            decoration: BoxDecoration(
                              color: filterController.hasValidSearch()
                                  ? Palette.primary
                                  : Colors.grey,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(Dimensions.cardRadius),
                              ),
                            ),
                            child: const Text(
                              searchButtonText,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: searchResultsController.obx(
          (state) {
            return ListView(
              children: [
                const Padding(
                  padding: Dimensions.horizontalPadding,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey),
                      ),
                    ),
                    child: Padding(
                      padding: successMessagePadding,
                      child: Center(
                        child: Text(
                          successMessage,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: AssetConstants.montserratFont,
                            fontWeight: FontWeight.w300,
                            fontSize: Dimensions.bigFontSize,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: Dimensions.smallHorizontalPadding,
                  child: RecipeGrid(
                    listOfRecipes: state!,
                    doOnTap: () {
                      searchResultsController.resetSearchResults();
                      filterController.resetFilters();
                    },
                  ),
                ),
              ],
            );
          },
          onLoading: Center(
            child: LottieBuilder.asset(AssetConstants.loadingAnimation),
          ),
          onEmpty: searchResultsController.isInitialized.isTrue
              ? const Center(
                  child: NoSearchResults(),
                )
              : _instructions(),
        ),
      );
    });
  }
}
