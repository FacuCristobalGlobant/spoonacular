import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/util/api_constants.dart';
import '../../core/util/asset_constants.dart';
import '../../core/util/dimensions.dart';
import '../../core/util/keys.dart';
import '../../core/util/palette.dart';
import '../../core/util/text_constants.dart';
import '../controller/ingredients_controller.dart';
import '../controller/nutritional_value_controller.dart';
import '../controller/recipe_controller.dart';
import '../controller/recipes_controller.dart';
import '../controller/similar_recipes_controller.dart';
import '../widget/company_logo.dart';
import '../widget/footer.dart';
import '../widget/not_found.dart';
import '../widget/recipe_card.dart';
import '../widget/recipe_card_vertical.dart';

class Home extends StatelessWidget {
  static const double sliverAppbarExtendedHeight = 200;
  static const EdgeInsets containerPadding = EdgeInsets.all(20);

  final RecipesController recipesController = Get.find<RecipesController>();

  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.mainBackground,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return CustomScrollView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                shadowColor: Colors.black54,
                automaticallyImplyLeading: false,
                pinned: true,
                backgroundColor: Palette.primary,
                actions: [
                  GestureDetector(
                    child: Padding(
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
                    onTap: () => Get.toNamed(
                      TextConstants.searchRoute,
                    ),
                  ),
                ],
                title: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Get.width * Dimensions.fivePercent,
                  ),
                  child: const CompanyLogo(),
                ),
                expandedHeight: sliverAppbarExtendedHeight,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  centerTitle: true,
                  title: constraints.maxWidth >= Dimensions.smallScreen
                      ? const Text(TextConstants.slogan)
                      : null,
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        AssetConstants.sliverBackground,
                        fit: BoxFit.cover,
                      ),
                      const ColoredBox(
                        color: Palette.darkOverlay,
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: (Get.width * Dimensions.fivePercent),
                  ),
                  child: Container(
                    padding: Dimensions.topPadding,
                    decoration: const BoxDecoration(
                      border: BorderDirectional(
                        bottom: BorderSide(
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          TextConstants.randomRecipesTitle,
                          style: TextStyle(
                            fontSize: Dimensions.bigFontSize,
                            fontWeight: FontWeight.w400,
                            color: Colors.black54,
                            fontFamily: AssetConstants.nothingFont,
                          ),
                        ),
                        GestureDetector(
                          key: Keys.refreshRecipes,
                          onTap: () => recipesController.getRandomRecipes(
                            ApiConstants.numberOfRandomRecipes,
                          ),
                          child: const Icon(
                            Icons.refresh,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              recipesController.obx(
                (state) {
                  Widget child;
                  if (constraints.maxWidth >= Dimensions.bigScreen) {
                    child = SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (
                          BuildContext context,
                          int index,
                        ) {
                          return Row(
                            children: [
                              Flexible(
                                child: GestureDetector(
                                  onTap: () {
                                    Get.find<IngredientsController>()
                                        .getListOfIngredients(
                                      state![index * 2].id,
                                    );
                                    Get.find<RecipeController>().getRecipeById(
                                      state[index * 2].id,
                                    );
                                    Get.find<NutritionalValueController>()
                                        .getNutritionalValue(
                                      state[index * 2].id,
                                    );
                                    Get.find<SimilarRecipesController>()
                                        .getSimilarRecipes(
                                      state[index * 2].id,
                                    );

                                    Get.toNamed(
                                      '${TextConstants.detailsRoute}/${state[index * 2].id}',
                                    );
                                  },
                                  child: RecipeCard(
                                    recipe: state![index * 2],
                                    cardIndex: index * 2,
                                  ),
                                ),
                              ),
                              ((index * 2) + 1 < state.length)
                                  ? Flexible(
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.find<IngredientsController>()
                                              .getListOfIngredients(
                                            state[(index * 2) + 1].id,
                                          );
                                          Get.find<RecipeController>()
                                              .getRecipeById(
                                            state[(index * 2) + 1].id,
                                          );
                                          Get.find<NutritionalValueController>()
                                              .getNutritionalValue(
                                            state[(index * 2) + 1].id,
                                          );
                                          Get.find<SimilarRecipesController>()
                                              .getSimilarRecipes(
                                            state[(index * 2) + 1].id,
                                          );
                                          Get.toNamed(
                                            '${TextConstants.detailsRoute}/${state[(index * 2) + 1].id}',
                                          );
                                        },
                                        child: RecipeCard(
                                          recipe: state[(index * 2) + 1],
                                          cardIndex: (index * 2) + 1,
                                        ),
                                      ),
                                    )
                                  : SizedBox.shrink(
                                      child: Container(),
                                    ),
                            ],
                          );
                        },
                        childCount: (state!.length / 2).ceil(),
                      ),
                    );
                  } else if (constraints.maxWidth < Dimensions.smallScreen) {
                    child = SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (
                          BuildContext context,
                          int index,
                        ) {
                          return GestureDetector(
                            onTap: () {
                              Get.find<IngredientsController>()
                                  .getListOfIngredients(
                                state![index].id,
                              );
                              Get.find<RecipeController>().getRecipeById(
                                state[index].id,
                              );
                              Get.find<NutritionalValueController>()
                                  .getNutritionalValue(
                                state[index].id,
                              );
                              Get.find<SimilarRecipesController>()
                                  .getSimilarRecipes(
                                state[index].id,
                              );
                              Get.toNamed(
                                '${TextConstants.detailsRoute}/${state[index].id}',
                              );
                            },
                            child: RecipeCardVertical(
                              recipe: state![index],
                              cardIndex: index,
                            ),
                          );
                        },
                        childCount: state!.length,
                      ),
                    );
                  } else {
                    child = SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (
                          BuildContext context,
                          int index,
                        ) {
                          return GestureDetector(
                            onTap: () {
                              Get.find<IngredientsController>()
                                  .getListOfIngredients(
                                state![index].id,
                              );
                              Get.find<RecipeController>().getRecipeById(
                                state[index].id,
                              );
                              Get.find<NutritionalValueController>()
                                  .getNutritionalValue(
                                state[index].id,
                              );
                              Get.find<SimilarRecipesController>()
                                  .getSimilarRecipes(
                                state[index].id,
                              );
                              Get.toNamed(
                                '${TextConstants.detailsRoute}/${state[index].id}',
                              );
                            },
                            child: RecipeCard(
                              recipe: state![index],
                              cardIndex: index,
                            ),
                          );
                        },
                        childCount: state!.length,
                      ),
                    );
                  }
                  return SliverPadding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Get.width * Dimensions.fivePercent,
                    ),
                    sliver: child,
                  );
                },
                onLoading: const SliverSafeArea(
                  minimum: Dimensions.safeAreaPadding,
                  sliver: SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: containerPadding,
                        child: CircularProgressIndicator(
                          color: Palette.primary,
                        ),
                      ),
                    ),
                  ),
                ),
                onEmpty: const SliverToBoxAdapter(
                  child: NotFound(),
                ),
                onError: (e) => SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: containerPadding,
                      child: Text(e.toString()),
                    ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: Footer(),
              )
            ],
          );
        },
      ),
    );
  }
}
