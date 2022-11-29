import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/util/dimensions.dart';
import '../../core/util/palette.dart';

class SectionTitle extends StatelessWidget {
  static const double titleVerticalPadding = 20;

  final String title;

  const SectionTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Get.width * Dimensions.fivePercent,
        vertical: titleVerticalPadding,
      ),
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(),
          ),
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Palette.textColor,
            fontSize: Dimensions.mediumFontSize,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}
