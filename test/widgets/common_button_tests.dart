import 'dart:async';

import 'package:flutter_ui_kit/color.dart';
import 'package:flutter_ui_kit/widgets/button_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../wrap_in_material_app.dart';

class FutureCallbackMock extends Mock implements Function {
  Future<void> call();
}

void testTextProp({
  Function group,
  Function setUp,
  Function testWidgets,
  String buttonText,
  Function buildButton,
}) {
  group('text prop', () {
    testWidgets('renders text', (WidgetTester tester) async {
      await tester.pumpWidget(wrapInMaterialApp(buildButton()));
      expect(find.text(buttonText), findsOneWidget);
    });
  });
}

void testOnPressedProp({
  Function group,
  Function setUp,
  Function testWidgets,
  String buttonText,
  Function buildButton,
  Type underlyingMaterialButtonType,
}) {
  group('onPressed prop', () {
    Future future;
    Completer completer;
    FutureCallback onPressed;

    setUp(() {
      completer = Completer<void>();
      future = completer.future;
      onPressed = FutureCallbackMock().call;
      when(onPressed()).thenAnswer((_) => future);
    });

    testWidgets('if onPressed is null should pass null to unrelying button',
        (WidgetTester tester) async {
      await tester.pumpWidget(wrapInMaterialApp(buildButton(onPressed: null)));
      expect(
          tester
              .widget<MaterialButton>(find.byType(underlyingMaterialButtonType))
              .enabled,
          isFalse);
    });

    testWidgets('on tap calls onPressed prop', (WidgetTester tester) async {
      await tester
          .pumpWidget(wrapInMaterialApp(buildButton(onPressed: onPressed)));
      await tester.tap(find.text(buttonText));
      await tester.pump();
      verify(onPressed()).called(1);
    });

    testWidgets('tapping twice results in one call to onPressed',
        (WidgetTester tester) async {
      await tester
          .pumpWidget(wrapInMaterialApp(buildButton(onPressed: onPressed)));
      await tester.tap(find.text(buttonText));
      await tester.pump();
      await tester.tap(find.text(buttonText));
      await tester.pump();
      verify(onPressed()).called(1);
    });

    testWidgets('when tapped disables underlying button until future completes',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester
            .pumpWidget(wrapInMaterialApp(buildButton(onPressed: onPressed)));
        await tester.tap(find.text(buttonText));
        await tester.pump();
        expect(
            tester
                .widget<MaterialButton>(
                    find.byType(underlyingMaterialButtonType))
                .enabled,
            isFalse);
        completer.complete();
        await future;
        await tester.pump();
        expect(
            tester
                .widget<MaterialButton>(
                    find.byType(underlyingMaterialButtonType))
                .enabled,
            isTrue);
      });
    });
  });
}

void testFullWidthProp({
  Function group,
  Function setUp,
  Function testWidgets,
  String buttonText,
  Function buildButton,
  Type underlyingMaterialButtonType,
}) {
  group('fullWidth prop', () {
    testWidgets('if true renders in container widget',
        (WidgetTester tester) async {
      await tester.pumpWidget(wrapInMaterialApp(buildButton(fullWidth: true)));
      expect(
          find.ancestor(
            of: find.byType(underlyingMaterialButtonType),
            matching: find.byType(Container),
          ),
          findsOneWidget);
    });

    testWidgets('if false renders not in container widget',
        (WidgetTester tester) async {
      await tester.pumpWidget(wrapInMaterialApp(buildButton(fullWidth: false)));
      expect(
          find.ancestor(
            of: find.byType(underlyingMaterialButtonType),
            matching: find.byType(Container),
          ),
          findsNothing);
    });
  });
}

void testNarrowProp({
  Function group,
  Function setUp,
  Function testWidgets,
  String buttonText,
  Function buildButton,
  Type underlyingMaterialButtonType,
}) {
  group('narrow prop', () {
    testWidgets('if true renders smaller padding', (WidgetTester tester) async {
      await tester.pumpWidget(wrapInMaterialApp(buildButton(narrow: true)));
      final button =
          // ignore: avoid_as
          find.byType(underlyingMaterialButtonType).evaluate().single.widget
              as MaterialButton;
      expect(button.padding, ButtonStyleConstants.narrowPadding);
    });

    testWidgets('if false renders larger padding', (WidgetTester tester) async {
      await tester.pumpWidget(wrapInMaterialApp(buildButton(narrow: false)));
      final button =
          // ignore: avoid_as
          find.byType(underlyingMaterialButtonType).evaluate().single.widget
              as MaterialButton;
      expect(button.padding, ButtonStyleConstants.widePadding);
    });
  });
}

void testPressingState({
  Function group,
  Function setUp,
  Function testWidgets,
  String buttonText,
  Function buildButton,
}) {
    group('pressing state', () {
      testWidgets('when button is pressed it changes text color',
          (WidgetTester tester) async {
        await tester.pumpWidget(
            wrapInMaterialApp(buildButton(onPressed: () {})));
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
            wrapInMaterialApp(buildButton(onPressed: null)));
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
}

