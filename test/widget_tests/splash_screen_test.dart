import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lottie/lottie.dart';
import 'package:spoonacular/presentation/view/home.dart';
import 'package:spoonacular/presentation/view/splash_screen.dart';

void main() {
  group('splash screen', () {
    testWidgets('a Lottie animation should appear when the application starts',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SplashScreen(),
          ),
        ),
      );

      expect(find.byType(Lottie), findsOneWidget);
    });
    testWidgets('the Home widget should appear after the animation',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SplashScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(Home), findsOneWidget);
    });
  });
}
