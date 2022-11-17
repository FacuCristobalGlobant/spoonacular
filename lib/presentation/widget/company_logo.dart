import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/util/asset_constants.dart';
import '../../core/util/dimensions.dart';
import '../../core/util/text_constants.dart';

class CompanyLogo extends StatelessWidget {
  static const double logoSquareSide = 50;

  const CompanyLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: Dimensions.smallPadding,
          child: SvgPicture.asset(
            AssetConstants.companyLogo,
            height: logoSquareSide,
            width: logoSquareSide,
          ),
        ),
        const Text(
          TextConstants.appTitle,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
