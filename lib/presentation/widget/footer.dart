import 'package:flutter/material.dart';
import 'company_logo.dart';
import '../../core/util/dimensions.dart';
import '../../core/util/palette.dart';

import '../../core/util/text_constants.dart';
import 'social_media_links.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Palette.primary,
      ),
      child: Padding(
        padding: Dimensions.smallPadding,
        child: Column(
          children: [
            DecoratedBox(
              decoration: const BoxDecoration(
                border: Border.symmetric(
                  horizontal: BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  CompanyLogo(),
                  SocialMediaLinks(),
                ],
              ),
            ),
            const Text(
              TextConstants.spoonacularCopyright,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
