import 'package:flutter/material.dart';

import 'core/util/text_constants.dart';
import 'presentation/view/splash_screen.dart';

void main() {
  runApp(const Spoonacular());
}

class Spoonacular extends StatelessWidget {
  const Spoonacular({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: TextConstants.appTitle,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const SplashScreen(),
    );
  }
}
