import 'package:flutter/material.dart';
import 'recipe_flag.dart';

import '../../core/util/asset_constants.dart';

class RecipeFlags extends StatelessWidget {
  static const double recipeTagSpacing = 5;

  final Map<String, bool> recipeProperties;

  const RecipeFlags({
    Key? key,
    required this.recipeProperties,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [];

    RecipeFlagsEnum.values.forEach((tag) {
      children.add(
        recipeTag(
          tag.tooltip,
          tag.asset,
          recipeProperties[tag.apiIdentifier]!,
        ),
      );
    });

    return Wrap(
      spacing: recipeTagSpacing,
      children: children,
    );
  }
}
