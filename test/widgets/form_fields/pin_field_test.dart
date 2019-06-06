import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui_kit/color.dart';
import 'package:flutter_ui_kit/widgets/form_fields/pin_field.dart';
import 'package:mockito/mockito.dart';

import '../../wrap_in_material_app.dart';

class OnSubmitMock extends Mock implements Function {
  Future<void> call(String value);
}

List<TextField> _findTextFields(WidgetTester tester) =>
    tester.widgetList<TextField>(find.byType(TextField)).toList();

TextField _findTextFieldAtIndex(WidgetTester tester, int index) =>
    _findTextFields(tester)[index];

void main() {
  group('Pin Field', () {
    testWidgets('renders correct number of inputs',
        (WidgetTester tester) async {
      await tester.pumpWidget(wrapInMaterialApp(PinField(
        fieldsCount: 3,
      )));

      expect(find.byType(TextField), findsNWidgets(3));
    });

    group('error message', () {
      testWidgets('renders error message if it is passed',
          (WidgetTester tester) async {
        const errorMessage = 'some error occured';
        await tester.pumpWidget(wrapInMaterialApp(PinField(
          fieldsCount: 3,
          errorMessage: errorMessage,
        )));

        expect(find.text(errorMessage), findsOneWidget);
      });

      testWidgets('renders red border if error message is passed',
          (WidgetTester tester) async {
        const errorMessage = 'some error occured';
        await tester.pumpWidget(wrapInMaterialApp(PinField(
          fieldsCount: 3,
          errorMessage: errorMessage,
        )));

        final textFields = _findTextFields(tester);
        expect(textFields.length, 3);
        textFields.forEach((TextField tf) {
          expect(
            tf.decoration.enabledBorder.borderSide.color,
            AppColor.red,
          );
          expect(
            tf.decoration.focusedBorder.borderSide.color,
            AppColor.red,
          );
        });
      });
    });

    group('onSubmit', () {
      testWidgets('should trigger onSubmit when all inputs are filled',
          (WidgetTester tester) async {
        const fieldsCount = 4;
        final onSubmit = OnSubmitMock().call;
        await tester.pumpWidget(wrapInMaterialApp(PinField(
          fieldsCount: fieldsCount,
          onSubmit: onSubmit,
        )));

        for (var i = 0; i < fieldsCount; i++) {
          final currentTextField = _findTextFieldAtIndex(tester, i);
          await tester.enterText(find.byWidget(currentTextField), '1');
          await tester.pump();
        }
        verify(onSubmit('1111'));
      });

      testWidgets('clears all inputs after submit',
          (WidgetTester tester) async {
        const fieldsCount = 4;
        final onSubmit = OnSubmitMock().call;
        await tester.pumpWidget(wrapInMaterialApp(PinField(
          fieldsCount: fieldsCount,
          onSubmit: onSubmit,
        )));

        for (var i = 0; i < fieldsCount; i++) {
          final currentTextField = _findTextFieldAtIndex(tester, i);
          await tester.enterText(find.byWidget(currentTextField), '1');
          await tester.pump();
        }
        verify(onSubmit('1111'));
        expect(find.text('1'), findsNothing);
      });
    });

    group('focus', () {
      testWidgets('if autofocus is set to true then focuses on first input',
          (WidgetTester tester) async {
        const fieldsCount = 4;
        await tester.pumpWidget(wrapInMaterialApp(PinField(
          fieldsCount: fieldsCount,
          autofocus: true,
        )));

        final textFields = _findTextFields(tester);
        expect(textFields.first.focusNode.hasFocus, true);
        expect(textFields.last.focusNode.hasFocus, false);
      });

      testWidgets(
          'if first input is empty, tapping on any input would focus on the first input',
          (WidgetTester tester) async {
        const fieldsCount = 4;
        await tester.pumpWidget(wrapInMaterialApp(PinField(
          fieldsCount: fieldsCount,
        )));

        final firstTextField = _findTextFieldAtIndex(tester, 0);
        for (var i = 1; i < fieldsCount; i++) {
          final currentTextField = _findTextFieldAtIndex(tester, i);
          await tester.tap(find.byWidget(currentTextField));
          expect(firstTextField.focusNode.hasFocus, true);
          expect(currentTextField.focusNode.hasFocus, false);
        }
      });

      testWidgets(
          'if first input is not empty, should focus on the second input',
          (WidgetTester tester) async {
        const fieldsCount = 4;
        await tester.pumpWidget(wrapInMaterialApp(PinField(
          fieldsCount: fieldsCount,
        )));

        final firstTextField = _findTextFieldAtIndex(tester, 0);
        await tester.enterText(find.byWidget(firstTextField), '1');
        await tester.pump();
        final secondTextField = _findTextFieldAtIndex(tester, 1);
        for (var i = 2; i < fieldsCount; i++) {
          final currentTextField = _findTextFieldAtIndex(tester, i);
          await tester.tap(find.byWidget(currentTextField));
          expect(secondTextField.focusNode.hasFocus, true);
          expect(currentTextField.focusNode.hasFocus, false);
        }
      });

      testWidgets('if input is filled should focus on the next input',
          (WidgetTester tester) async {
        const fieldsCount = 4;
        await tester.pumpWidget(wrapInMaterialApp(PinField(
          fieldsCount: fieldsCount,
        )));

        final textFields = _findTextFields(tester);
        expect(textFields.length, 4);
        for (var i = 0; i < fieldsCount - 1; i++) {
          final currentTextField = _findTextFieldAtIndex(tester, i);
          await tester.enterText(find.byWidget(currentTextField), '1');
          await tester.pump();
          final nextTextField = _findTextFieldAtIndex(tester, i + 1);
          expect(nextTextField.focusNode.hasFocus, true);
        }
      });

      testWidgets(
          'when all inputs are filled should unfocus from the last input',
          (WidgetTester tester) async {
        const fieldsCount = 4;
        await tester.pumpWidget(wrapInMaterialApp(PinField(
          fieldsCount: fieldsCount,
        )));

        for (var i = 0; i < fieldsCount - 1; i++) {
          final currentTextField = _findTextFieldAtIndex(tester, i);
          await tester.enterText(find.byWidget(currentTextField), '1');
          await tester.pump();
        }
        final lastTextField = _findTextFieldAtIndex(tester, fieldsCount - 1);
        await tester.enterText(find.byWidget(lastTextField), '1');
        expect(lastTextField.focusNode.hasFocus, false);
      });
    });

    group('style', () {
      testWidgets('renders grey border by default',
          (WidgetTester tester) async {
        await tester.pumpWidget(wrapInMaterialApp(PinField(
          fieldsCount: 3,
        )));

        final textFields = _findTextFields(tester);
        expect(textFields.length, 3);
        textFields.forEach((TextField tf) {
          expect(
            tf.decoration.enabledBorder.borderSide.color,
            AppColor.grey,
          );
          expect(
            tf.decoration.focusedBorder.borderSide.color,
            AppColor.grey,
          );
        });
      });

      testWidgets('renders green border if input is filled',
          (WidgetTester tester) async {
        await tester.pumpWidget(wrapInMaterialApp(PinField(
          fieldsCount: 2,
        )));

        await tester.enterText(
          find.byType(TextField).first,
          '1',
        );
        await tester.pump();

        final textFields = _findTextFields(tester);
        expect(textFields.length, 2);
        expect(
          textFields.first.decoration.enabledBorder.borderSide.color,
          AppColor.green,
        );
        expect(
          textFields.last.decoration.enabledBorder.borderSide.color,
          AppColor.grey,
        );
      });
    });
  });
}
