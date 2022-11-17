import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spoonacular/presentation/widget/company_logo.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  group('Company logo test', () {
    testWidgets('should render an SvgPicture widget', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CompanyLogo(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(
        find.byType(SvgPicture),
        findsOneWidget,
      );
    });
  });
}
