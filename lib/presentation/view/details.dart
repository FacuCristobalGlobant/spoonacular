import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

import '../../core/util/asset_constants.dart';
import '../../core/util/dimensions.dart';
import '../../core/util/palette.dart';
import '../../core/util/text_constants.dart';
import '../../data/model/ingredient_model.dart';
import '../../data/model/recipe_model.dart';
import '../controller/ingredients_controller.dart';
import '../controller/nutritional_value_controller.dart';
import '../controller/recipe_controller.dart';
import '../controller/similar_recipes_controller.dart';
import '../widget/company_logo.dart';
import '../widget/footer.dart';
import '../widget/ingredient_card.dart';
import '../widget/recipe_card_vertical.dart';
import '../widget/recipe_flags.dart';
import '../widget/section_title.dart';

class Details extends StatelessWidget {
  static const double similarRecipeWidth = 200;
  static const double gridPadding = 20;
  static const double gridMaxCrossAxisExtent = 250;
  static const double ingredientCrossAxisExtent = 200;
  static const double gridSpacing = 10;
  static const int similarRecipesTitleMaxLines = 1;
  static const String idParameterField = 'id';
  static const double gridChildAspectRatio = .8;
  static const String noSimilarRecipesMessage = 'No similar recipes found';
  static const int mainFlex = 2;
  static const int sideFlex = 1;

  final RecipeController recipeController = Get.find<RecipeController>();
  final NutritionalValueController nutritionalValueController =
      Get.find<NutritionalValueController>();
  final IngredientsController ingredientsController =
      Get.find<IngredientsController>();
  final SimilarRecipesController similarRecipesController =
      Get.find<SimilarRecipesController>();

  Details({Key? key}) : super(key: key);

  Widget _buildNutritionalValue(String? state) {
    return Html(
      data: state!,
      style: {
        '*': Style(
          padding: Dimensions.smallerPadding,
          textAlign: TextAlign.center,
        )
      },
    );
  }

  Widget _buildSimilarRecipes(List<RecipeModel>? state) {
    {
      List<Widget> children = [];
      state?.forEach((recipe) {
        children.add(
          Container(
            padding: Dimensions.smallerPadding,
            width: similarRecipeWidth,
            child: GestureDetector(
              onTap: () {
                ingredientsController.getListOfIngredients(
                  recipe.id,
                );
                recipeController.getRecipeById(
                  recipe.id,
                );
                nutritionalValueController.getNutritionalValue(
                  recipe.id,
                );
                similarRecipesController.getSimilarRecipes(
                  recipe.id,
                );

                Get.toNamed(
                  '${TextConstants.detailsRoute}/${recipe.id}',
                );
              },
              child: RecipeCardVertical(
                recipe: recipe,
                fontSize: Dimensions.smallFontSize,
                titleMaxLines: similarRecipesTitleMaxLines,
              ),
            ),
          ),
        );
      });
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Get.width * .01,
          vertical: gridPadding,
        ),
        child: Wrap(
          alignment: WrapAlignment.center,
          children: children,
        ),
      );
    }
  }

  Widget _buildIngredients(List<IngredientModel>? state) {
    {
      final List<IngredientCard> children = [];
      state?.forEach((ingredient) {
        children.add(IngredientCard(ingredient: ingredient));
      });
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.1,
          vertical: gridPadding,
        ),
        child: GridView.extent(
          clipBehavior: Clip.none,
          maxCrossAxisExtent: gridMaxCrossAxisExtent,
          childAspectRatio: gridChildAspectRatio,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          mainAxisSpacing: gridSpacing,
          crossAxisSpacing: gridSpacing,
          children: children,
        ),
      );
    }
  }

  Widget _buildHeader(RecipeModel? state) {
    return Column(
      children: [
        Padding(
          padding: Dimensions.horizontalPadding,
          child: Column(
            children: [
              Padding(
                padding: Dimensions.topPadding,
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide()),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          state!.title!,
                          style: const TextStyle(
                            color: Palette.textColor,
                            fontSize: Dimensions.bigFontSize,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            state.aggregateLikes!.toString(),
                          ),
                          Padding(
                            padding: Dimensions.smallPadding,
                            child: Image.asset(
                              AssetConstants.likeIcon,
                              width: Dimensions.searchIconWidth,
                              filterQuality: FilterQuality.medium,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: Dimensions.topPadding,
                child: LayoutBuilder(
                  builder: (
                    BuildContext context,
                    BoxConstraints constraints,
                  ) {
                    if (constraints.maxWidth > Dimensions.smallScreen) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: Get.width * 0.4,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  offset: Dimensions.shadowOffset,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: Dimensions.smallPadding,
                              child: state.image != null
                                  ? Image.network(
                                      state.image!,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      AssetConstants.noImg,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                RecipeFlags(
                                  recipeProperties: state.getRecipeTags(),
                                ),
                                Html(
                                  data: state.summary!,
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(Get.width * 0.01),
                            child: Container(
                              width: Get.width * 0.8,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    offset: Dimensions.shadowOffset,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: Dimensions.smallPadding,
                                child: Image.network(
                                  state.image!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: Dimensions.smallPadding,
                            child: SizedBox(
                              width: Get.width * 0.8,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  RecipeFlags(
                                    recipeProperties: state.getRecipeTags(),
                                  ),
                                  Html(
                                    data: state.summary!,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.mainBackground,
      appBar: AppBar(
        backgroundColor: Palette.primary,
        automaticallyImplyLeading: false,
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
      body: ListView(
        children: [
          recipeController.obx(
            (state) => _buildHeader(state),
            onLoading: const SafeArea(
              minimum: Dimensions.safeAreaPadding,
              child: Center(
                child: CircularProgressIndicator(
                  color: Palette.primary,
                ),
              ),
            ),
            onError: (e) => Center(
              child: Text(e.toString()),
            ),
          ),
          const SectionTitle(title: TextConstants.ingredientsTitle),
          LayoutBuilder(
            builder: (
              BuildContext context,
              BoxConstraints constraints,
            ) {
              if (constraints.maxWidth > Dimensions.smallScreen) {
                return Flex(
                  direction: Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: mainFlex,
                      child: ingredientsController.obx(
                        (state) => _buildIngredients(state),
                        onLoading: const SafeArea(
                          minimum: Dimensions.safeAreaPadding,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Palette.primary,
                            ),
                          ),
                        ),
                        onError: (e) => Center(
                          child: Text(e.toString()),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: sideFlex,
                      child: nutritionalValueController.obx(
                        (state) => _buildNutritionalValue(state),
                        onLoading: const Center(
                          child: CircularProgressIndicator(
                            color: Palette.primary,
                          ),
                        ),
                      ),
                    )
                  ],
                );
              } else {
                return Column(
                  children: [
                    ingredientsController.obx(
                      (state) => _buildIngredients(state),
                      onLoading: const SafeArea(
                        minimum: Dimensions.safeAreaPadding,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Palette.primary,
                          ),
                        ),
                      ),
                      onError: (e) => Center(
                        child: Text(e.toString()),
                      ),
                    ),
                    nutritionalValueController.obx(
                      (state) => _buildNutritionalValue(state),
                      onLoading: const Center(
                        child: CircularProgressIndicator(
                          color: Palette.primary,
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
          const SectionTitle(
            title: TextConstants.instructionsTitle,
          ),
          recipeController.obx(
            (state) => Padding(
              padding: Dimensions.horizontalPadding,
              child: Html(
                data: state?.instructions ?? TextConstants.emptyString,
                style: {
                  '*': Style(
                    fontFamily: AssetConstants.montserratFont,
                    fontWeight: FontWeight.w300,
                  )
                },
              ),
            ),
            onLoading: const Center(
              child: CircularProgressIndicator(
                color: Palette.primary,
              ),
            ),
          ),
          const SectionTitle(
            title: TextConstants.similarRecipesTitle,
          ),
          similarRecipesController.obx(
            (state) => _buildSimilarRecipes(state),
            onLoading: const Center(
              child: CircularProgressIndicator(
                color: Palette.primary,
              ),
            ),
            onEmpty: const Center(
              child: Text(noSimilarRecipesMessage),
            ),
          ),
          const Footer(),
        ],
      ),
    );
  }
}
