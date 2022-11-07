import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

import '../../core/util/asset_constants.dart';
import '../../core/util/dimensions.dart';

import 'home.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      nextScreen: const Home(),
      splash: Lottie.asset(
        AssetConstants.splashScreen,
      ),
      duration: Dimensions.splashScreenDuration,
      splashIconSize: Dimensions.splashScreenSize,
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.fade,
      animationDuration: const Duration(
        seconds: Dimensions.splashFadeInDuration,
      ),
    );
  }
}
