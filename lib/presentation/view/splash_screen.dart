import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

import '../../core/util/asset_constants.dart';

import '../../core/util/text_constants.dart';
import 'home.dart';

class SplashScreen extends StatelessWidget {
  static const double splashScreenSize = 300;
  static const int splashFadeInDuration = 1;
  static const int splashScreenDuration = 2000;

  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      nextScreen: Home(),
      nextRoute: TextConstants.homeRoute,
      splash: Lottie.asset(
        AssetConstants.splashScreen,
      ),
      duration: splashScreenDuration,
      splashIconSize: splashScreenSize,
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.fade,
      animationDuration: const Duration(
        seconds: splashFadeInDuration,
      ),
    );
  }
}
