import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/util/api_constants.dart';
import '../../core/util/asset_constants.dart';
import '../../core/util/dimensions.dart';
import '../../data/model/ingredient_model.dart';

class IngredientCard extends StatelessWidget {
  static const ingredientNameTopPadding = EdgeInsets.only(top: 5);
  static const double imageHeight = 120;
  static const int ingredientTitleMaxlines = 1;
  static const String ingredientMeasurementUnit = 'us';
  static const String ingredientMeasurementValueField = 'value';
  static const String ingredientMeasurementUnitField = 'value';

  final IngredientModel ingredient;

  const IngredientCard({
    Key? key,
    required this.ingredient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Padding(
        padding: Dimensions.smallPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Align(
              alignment: AlignmentDirectional.topCenter,
              child: Image.network(
                '${ApiConstants.imageBase}${ingredient.image}',
                fit: BoxFit.contain,
                height: imageHeight,
                errorBuilder: (context, object, stackTrace) => Image.asset(
                  AssetConstants.noImg,
                ),
              ),
            ),
            Container(
              padding: ingredientNameTopPadding,
              decoration: const BoxDecoration(
                border: Border(top: BorderSide()),
              ),
              child: Tooltip(
                message: ingredient.name!.capitalize!,
                child: Text(
                  ingredient.name!.capitalize!,
                  style: const TextStyle(
                    fontSize: Dimensions.smallFontSize,
                    fontWeight: FontWeight.w300,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: ingredientTitleMaxlines,
                ),
              ),
            ),
            Text(
              '${ingredient.amount![ingredientMeasurementUnit][ingredientMeasurementValueField]} ${ingredient.amount![ingredientMeasurementUnit][ingredientMeasurementUnitField]}',
            ),
          ],
        ),
      ),
    );
  }
}
