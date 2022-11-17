import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import '../../core/util/text_constants.dart';
import '../controller/recipe_summary_controller.dart';
import 'recipe_flags.dart';

import '../../core/util/dimensions.dart';
import '../../data/model/recipe_model.dart';
import 'cooking_time.dart';

class RecipeCardVertical extends StatelessWidget {
  final RecipeModel recipe;
  final int cardIndex;
  final RecipeSummaryController summaryController =
      Get.find<RecipeSummaryController>();

  RecipeCardVertical({
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
        child: Column(
          children: [
            Stack(
              children: [
                Image.network(
                  recipe.image!,
                  height: Dimensions.recipeImageHeight,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: Dimensions.timerOffset,
                  left: Dimensions.timerOffset,
                  child: CookingTime(
                    time: TimeOfDay(
                      hour: recipe.readyInMinutes! ~/ Dimensions.minutesInHour,
                      minute: recipe.readyInMinutes! % Dimensions.minutesInHour,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: Dimensions.smallPadding,
              child: Text(
                recipe.title!,
                style: const TextStyle(
                  fontSize: Dimensions.bigFontSize,
                  fontWeight: FontWeight.w300,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            Padding(
              padding: Dimensions.smallPadding,
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
                        milliseconds: Dimensions.summaryAnimationDuration,
                      ),
                      curve: Curves.easeIn,
                      child: Html(
                        data: recipe.summary,
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
    );
  }
}
