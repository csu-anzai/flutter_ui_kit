import 'package:flutter_ui_kit/color.dart';
import 'package:flutter_ui_kit/widgets/button_common.dart';
import 'package:flutter_ui_kit/widgets/outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../wrap_in_material_app.dart';
import 'common_button_tests.dart';

void main() {
  group('OutlinedButton', () {
    const buttonText = 'Click me';

    group('pressing state', () {
      testWidgets('when button is pressed it changes text color',
          (WidgetTester tester) async {
        await tester.pumpWidget(
            wrapInMaterialApp(OutlinedButton(buttonText, onPressed: () {})));
        expect(tester.widget<Text>(find.text(buttonText)).style.color,
            AppColor.green);
        final gesture = await tester.createGesture();
        await gesture.down(tester.getCenter(find.text(buttonText)));
        await tester.pumpAndSettle(const Duration(seconds: 1));
        expect(tester.widget<Text>(find.text(buttonText)).style.color,
            AppColor.darkerGreen);
        await gesture.up();
        await tester.pumpAndSettle(const Duration(seconds: 1));
        expect(tester.widget<Text>(find.text(buttonText)).style.color,
            AppColor.green);
      });

      testWidgets(
          'if button is disabled should have grey text regardless of tap events',
          (WidgetTester tester) async {
        await tester.pumpWidget(
            wrapInMaterialApp(OutlinedButton(buttonText, onPressed: null)));
        expect(tester.widget<Text>(find.text(buttonText)).style.color,
            AppColor.mediumGrey);
        final gesture = await tester.createGesture();
        await gesture.down(tester.getCenter(find.text(buttonText)));
        await tester.pumpAndSettle(const Duration(seconds: 1));
        expect(tester.widget<Text>(find.text(buttonText)).style.color,
            AppColor.mediumGrey);
        await gesture.up();
        await tester.pumpAndSettle(const Duration(seconds: 1));
        expect(tester.widget<Text>(find.text(buttonText)).style.color,
            AppColor.mediumGrey);
      });
    });

    testTextProp(
      group: group,
      setUp: setUp,
      testWidgets: testWidgets,
      buttonText: buttonText,
      buildButton: () => OutlinedButton(buttonText, onPressed: () {}),
    );

    testOnPressedProp(
      group: group,
      setUp: setUp,
      testWidgets: testWidgets,
      buttonText: buttonText,
      buildButton: ({FutureCallback onPressed}) =>
          OutlinedButton(buttonText, onPressed: onPressed),
      underlyingMaterialButtonType: OutlineButton,
    );

    testFullWidthProp(
      group: group,
      setUp: setUp,
      testWidgets: testWidgets,
      buttonText: buttonText,
      buildButton: ({bool fullWidth}) =>
          OutlinedButton(buttonText, onPressed: () {}, fullWidth: fullWidth),
      underlyingMaterialButtonType: OutlineButton,
    );

    testNarrowProp(
      group: group,
      setUp: setUp,
      testWidgets: testWidgets,
      buttonText: buttonText,
      buildButton: ({bool narrow}) =>
          OutlinedButton(buttonText, onPressed: () {}, narrow: narrow),
      underlyingMaterialButtonType: OutlineButton,
    );
  });
}
