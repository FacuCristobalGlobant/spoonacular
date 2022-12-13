import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/util/asset_constants.dart';

class NoSearchResults extends StatelessWidget {
  static const String notFoundMessage = 'No recipes found';
  static const double messageFontSize = 40;

  const NoSearchResults({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AssetConstants.notFoundImage,
            width: Get.width / 2,
            height: Get.height / 2,
          ),
          const Text(
            notFoundMessage,
            style: TextStyle(
              fontSize: messageFontSize,
              fontFamily: AssetConstants.nothingFont,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
