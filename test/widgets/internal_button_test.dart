import 'dart:async';

import 'package:change_ui_kit/widgets/internal_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../wrap_in_material_app.dart';

void main() {
  group('InternalButton', () {
    group('child prop', () {
      testWidgets('renders child', (WidgetTester tester) async {
        const title = 'Title';
        await tester.pumpWidget(wrapInMaterialApp(InternalButton(
          child: const Text(title),
          onPressed: () {},
        )));
        expect(find.text(title), findsOneWidget);
      });
    });

    group('onPressed prop', () {
      String title;
      Future future;
      Completer completer;
      FutureCallback onPressed;

      setUp(() {
        title = 'Title';
        completer = Completer<void>();
        future = completer.future;
        onPressed = FutureCallbackMock().call;
        when(onPressed()).thenAnswer((_) => future);
      });

      testWidgets('if onPressed is null should pass null to RaisedButton',
          (WidgetTester tester) async {
        await tester.pumpWidget(wrapInMaterialApp(InternalButton(
          child: Text(title),
          onPressed: null,
        )));
        expect(tester.widget<RaisedButton>(find.byType(RaisedButton)).enabled,
            isFalse);
      });

      testWidgets('on tap calls onPressed prop', (WidgetTester tester) async {
        await tester.pumpWidget(wrapInMaterialApp(InternalButton(
          child: Text(title),
          onPressed: onPressed,
        )));
        await tester.tap(find.text(title));
        await tester.pump();
        verify(onPressed()).called(1);
      });

      testWidgets('tapping twice results in one call to onPressed',
          (WidgetTester tester) async {
        await tester.pumpWidget(wrapInMaterialApp(InternalButton(
          child: Text(title),
          onPressed: onPressed,
        )));
        await tester.tap(find.text(title));
        await tester.pump();
        await tester.tap(find.text(title));
        await tester.pump();
        verify(onPressed()).called(1);
      });

      testWidgets(
          'when tapped disables underlying button until future completes',
          (WidgetTester tester) async {
        await tester.runAsync(() async {
          await tester.pumpWidget(wrapInMaterialApp(InternalButton(
            child: Text(title),
            onPressed: onPressed,
          )));
          await tester.tap(find.text(title));
          await tester.pump();
          expect(tester.widget<RaisedButton>(find.byType(RaisedButton)).enabled,
              isFalse);
          completer.complete();
          await future;
          await tester.pump();
          expect(tester.widget<RaisedButton>(find.byType(RaisedButton)).enabled,
              isTrue);
        });
      });
    });

    group('fullWidth prop', () {
      testWidgets('if true renders in container widget',
          (WidgetTester tester) async {
        const title = 'Title';
        await tester.pumpWidget(wrapInMaterialApp(InternalButton(
          child: const Text(title),
          onPressed: () {},
          fullWidth: true,
        )));
        expect(
            find.ancestor(
              of: find.byType(RaisedButton),
              matching: find.byType(Container),
            ),
            findsOneWidget);
      });
      testWidgets('if false renders not in container widget',
          (WidgetTester tester) async {
        const title = 'Title';
        await tester.pumpWidget(wrapInMaterialApp(InternalButton(
          child: const Text(title),
          onPressed: () {},
          fullWidth: false,
        )));
        expect(
            find.ancestor(
              of: find.byType(RaisedButton),
              matching: find.byType(Container),
            ),
            findsNothing);
      });
    });
  });
}
class FutureCallbackMock extends Mock implements Function {
  Future<void> call();
}
