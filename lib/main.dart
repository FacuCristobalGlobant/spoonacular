import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'config/route/routes.dart';
import 'recipes_bindings.dart';

import 'core/util/asset_constants.dart';
import 'core/util/palette.dart';
import 'core/util/text_constants.dart';

void main() async {
  final RecipesBinding binding = RecipesBinding();
  binding.instantiateDependencies();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Spoonacular());
}

class Spoonacular extends StatelessWidget {
  const Spoonacular({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: Routes.routes,
      debugShowCheckedModeBanner: false,
      initialRoute: TextConstants.splashScreenRoute,
      title: TextConstants.appTitle,
      theme: ThemeData(
        fontFamily: AssetConstants.montserratFont,
        primaryColor: Palette.primary,
      ),
    );
  }
}
