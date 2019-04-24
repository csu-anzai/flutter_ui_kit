import 'dart:async';

import 'package:change_ui_kit/theme.dart';
import 'package:change_ui_kit/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  group('InternalButton', () {
    group('child prop', () {
      testWidgets('renders child', (WidgetTester tester) async {
        const title = 'Title';
        await tester.pumpWidget(_wrapInMaterialApp(
            InternalButton(child: const Text(title), onPressed: () {})));
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

      testWidgets('on tap calls onPressed prop', (WidgetTester tester) async {
        await tester.pumpWidget(_wrapInMaterialApp(InternalButton(
          child: Text(title),
          onPressed: onPressed,
        )));
        await tester.tap(find.text(title));
        await tester.pump();
        verify(onPressed()).called(1);
      });

      testWidgets('tapping twice results in one call to onPressed',
          (WidgetTester tester) async {
        await tester.pumpWidget(_wrapInMaterialApp(InternalButton(
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
          await tester.pumpWidget(_wrapInMaterialApp(InternalButton(
            child: Text(title),
            onPressed: onPressed,
          )));
          await tester.tap(find.text(title));
          await tester.pump();
          expect(tester.widget<FlatButton>(find.byType(FlatButton)).enabled,
              isFalse);
          completer.complete();
          await future;
          await tester.pump();
          expect(tester.widget<FlatButton>(find.byType(FlatButton)).enabled,
              isTrue);
        });
      });
    });
  });
}

MaterialApp _wrapInMaterialApp(Widget widget) {
  return MaterialApp(
    theme: theme,
    home: widget,
  );
}

class FutureCallbackMock extends Mock implements Function {
  Future<void> call();
}
