import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import '../../core/util/asset_constants.dart';
import '../../core/util/text_constants.dart';
import '../controller/recipe_summary_controller.dart';
import 'recipe_flags.dart';

import '../../core/util/dimensions.dart';
import '../../data/model/recipe_model.dart';
import 'cooking_time.dart';

class RecipeCard extends StatelessWidget {
  static const EdgeInsets flagPadding = EdgeInsets.symmetric(
    horizontal: 5,
  );
  static const int titleMaxLines = 1;
  static const EdgeInsets recipeDetailsPadding =
      EdgeInsets.symmetric(horizontal: 10.0);

  final RecipeModel recipe;
  final int cardIndex;
  final RecipeSummaryController summaryController =
      Get.find<RecipeSummaryController>();

  RecipeCard({
    Key? key,
    required this.recipe,
    required this.cardIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Dimensions.smallerPadding,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.cardRadius),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Dimensions.shadowOffset,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                recipe.image != null
                    ? Image.network(
                        recipe.image!,
                        height: Dimensions.recipeImageHeight,
                        width: Dimensions.recipeImageWidth,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        AssetConstants.noImg,
                        height: Dimensions.recipeImageHeight,
                        width: Dimensions.recipeImageWidth,
                        fit: BoxFit.cover,
                      ),
                Positioned(
                  top: Dimensions.timerOffset,
                  left: Dimensions.timerOffset,
                  child: CookingTime(
                    time: TimeOfDay(
                      hour: (recipe.readyInMinutes ?? 0) ~/
                          Dimensions.minutesInHour,
                      minute: (recipe.readyInMinutes ?? 0) %
                          Dimensions.minutesInHour,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: recipeDetailsPadding,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: Dimensions.smallPadding,
                      child: Tooltip(
                        message: recipe.title ?? TextConstants.emptyString,
                        child: Text(
                          recipe.title ?? TextConstants.emptyString,
                          style: const TextStyle(
                            fontSize: Dimensions.bigFontSize,
                            fontWeight: FontWeight.w300,
                            decoration: TextDecoration.underline,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: titleMaxLines,
                        ),
                      ),
                    ),
                    Padding(
                      padding: flagPadding,
                      child: RecipeFlags(
                        recipeProperties: recipe.getRecipeTags(),
                      ),
                    ),
                    Padding(
                      padding: Dimensions.smallPadding,
                      child: Obx(
                        () => Column(
                          children: [
                            AnimatedSize(
                              duration: const Duration(
                                milliseconds:
                                    Dimensions.summaryAnimationDuration,
                              ),
                              curve: Curves.easeIn,
                              child: Html(
                                data:
                                    recipe.summary ?? TextConstants.emptyString,
                                style: {
                                  '*': Style(
                                    textAlign: TextAlign.start,
                                    textOverflow: TextOverflow.fade,
                                    maxLines: summaryController.visibleSummaries
                                            .contains(cardIndex)
                                        ? null
                                        : Dimensions.summaryMaxLines,
                                  )
                                },
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                summaryController.switchHiding(cardIndex);
                              },
                              child: Text(
                                summaryController.containsIndex(cardIndex)
                                    ? TextConstants.showLessText
                                    : TextConstants.showMoreText,
                                style: const TextStyle(
                                  color: Colors.blue,
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
          ],
        ),
      ),
    );
  }
}
