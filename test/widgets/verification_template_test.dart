import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui_kit/widgets/filled_button.dart';
import 'package:flutter_ui_kit/widgets/layout/verification_template.dart';

import '../wrap_in_material_app.dart';

void main() {
  group('VerificationTemplate', () {
    testWidgets('renders the expected layout', (WidgetTester tester) async {
      const header = 'Header';
      const text =
          'Body';
      final pic = SvgPicture.asset(
        'assets/update-app.svg',
        width: 285.0,
        height: 215.0,
      );
      final action = FilledButton(
        'Button',
        onPressed: () {},
        fullWidth: true,
        narrow: false,
      );
      await tester.pumpWidget(wrapInMaterialApp(VerificationTemplate(header, text, pic, action)));

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text(header), findsOneWidget);
      expect(find.text(text), findsOneWidget);
      expect(find.byType(SvgPicture), findsOneWidget);
      expect(find.text('Button'), findsOneWidget);
    });
  });
}
