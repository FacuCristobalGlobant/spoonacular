import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'recipes_bindings.dart';

import 'core/util/asset_constants.dart';
import 'core/util/palette.dart';
import 'core/util/text_constants.dart';
import 'presentation/view/splash_screen.dart';

void main() async {
  await dotenv.load(fileName: AssetConstants.environmentVariables);
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
      title: TextConstants.appTitle,
      theme: ThemeData(
        fontFamily: AssetConstants.montserratFont,
        primaryColor: Palette.primary,
      ),
      home: const SplashScreen(),
    );
  }
}
