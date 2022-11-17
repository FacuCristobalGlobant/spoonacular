import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

const double recipeTagSide = 30;

Widget recipeTag(String message, String asset, bool hasTag) {
  return Tooltip(
    message: message,
    child: Container(
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: SvgPicture.asset(
        asset,
        width: recipeTagSide,
        height: recipeTagSide,
        color: hasTag ? null : Colors.grey,
        colorBlendMode: BlendMode.saturation,
      ),
    ),
  );
}
