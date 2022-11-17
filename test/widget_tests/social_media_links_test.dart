import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spoonacular/presentation/widget/social_media_links.dart';

void main() {
  group('Social media links test', () {
    testWidgets('should have a follow us message and 3 svg images',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SocialMediaLinks(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(
        find.byType(SvgPicture),
        findsNWidgets(3),
      );
    });
  });
}
