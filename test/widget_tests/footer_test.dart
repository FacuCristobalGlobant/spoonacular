import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spoonacular/presentation/widget/company_logo.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spoonacular/presentation/widget/footer.dart';

void main() {
  group('Footer test', () {
    testWidgets('should have the company logo and social media links',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Footer(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(
        find.byType(CompanyLogo),
        findsOneWidget,
      );
      expect(
        find.byType(SvgPicture),
        findsNWidgets(4),
      );
    });
  });
}
