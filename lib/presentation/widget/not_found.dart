import 'package:flutter/material.dart';

import '../../core/util/asset_constants.dart';
import '../../core/util/dimensions.dart';
import '../../core/util/text_constants.dart';

class NotFound extends StatelessWidget {
  static const double notFoundImageSize = 400;

  const NotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: Dimensions.mediumPadding,
        child: Column(
          children: [
            Image.asset(
              AssetConstants.notFoundImage,
              width: notFoundImageSize,
            ),
            const Text(
              TextConstants.notFoundMessage,
              style: TextStyle(
                fontSize: Dimensions.bigFontSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
