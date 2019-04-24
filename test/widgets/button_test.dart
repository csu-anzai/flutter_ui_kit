import 'package:change_ui_kit/theme.dart';
import 'package:change_ui_kit/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('InternalButton', () {
    testWidgets('renders child', (WidgetTester tester) async {
      const title = 'Title';
      await tester.pumpWidget(_wrapInMaterialApp(InternalButton(
        child: Text(title),
        onPressed: () {}
      )));
      expect(find.text(title), findsOneWidget);
    });
  });
}

MaterialApp _wrapInMaterialApp(Widget widget) {
  return MaterialApp(
    theme: theme,
    home: widget,
  );
}
