import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'recipe_card_vertical.dart';

import '../../core/util/dimensions.dart';
import '../../core/util/text_constants.dart';
import '../../data/model/recipe_model.dart';
import '../controller/ingredients_controller.dart';
import '../controller/nutritional_value_controller.dart';
import '../controller/recipe_controller.dart';
import '../controller/similar_recipes_controller.dart';

class RecipeGrid extends StatelessWidget {
  static const double similarRecipeWidth = 200;
  static const double gridPadding = 20;
  static const int similarRecipesTitleMaxLines = 1;

  final List<RecipeModel> listOfRecipes;
  final RecipeController recipeController = Get.find<RecipeController>();
  final NutritionalValueController nutritionalValueController =
      Get.find<NutritionalValueController>();
  final IngredientsController ingredientsController =
      Get.find<IngredientsController>();
  final SimilarRecipesController similarRecipesController =
      Get.find<SimilarRecipesController>();
  final Function? doOnTap;

  RecipeGrid({
    Key? key,
    required this.listOfRecipes,
    this.doOnTap,
  }) : super(
          key: key,
        );

  void getToRecipe(RecipeModel recipe) {
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
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    listOfRecipes.forEach((recipe) {
      children.add(
        Container(
          padding: Dimensions.smallerPadding,
          width: similarRecipeWidth,
          child: GestureDetector(
            onTap: () {
              doOnTap?.call();
              getToRecipe(recipe);
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
