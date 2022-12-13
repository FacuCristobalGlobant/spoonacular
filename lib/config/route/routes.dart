import 'package:get/get_navigation/src/routes/get_route.dart';

import '../../core/util/text_constants.dart';
import '../../presentation/view/details.dart';
import '../../presentation/view/home.dart';
import '../../presentation/view/search.dart';
import '../../presentation/view/splash_screen.dart';

abstract class Routes {
  static List<GetPage> routes = [
    GetPage(
      name: TextConstants.homeRoute,
      page: () => Home(),
    ),
    GetPage(
      name: TextConstants.searchRoute,
      page: () => Search(),
    ),
    GetPage(
      name: '${TextConstants.detailsRoute}/:id',
      page: () => Details(),
    ),
    GetPage(
      name: TextConstants.splashScreenRoute,
      page: () => const SplashScreen(),
    ),
  ];
}
