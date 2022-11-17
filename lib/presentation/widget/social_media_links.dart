import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/util/asset_constants.dart';
import '../../core/util/text_constants.dart';

class SocialMediaLinks extends StatelessWidget {
  const SocialMediaLinks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          TextConstants.socialMediaTitle,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        Row(
          children: [
            SvgPicture.asset(
              AssetConstants.instagramIcon,
              color: Colors.white,
            ),
            SvgPicture.asset(
              AssetConstants.facebookIcon,
              color: Colors.white,
            ),
            SvgPicture.asset(
              AssetConstants.twitterIcon,
              color: Colors.white,
            ),
          ],
        )
      ],
    );
  }
}
