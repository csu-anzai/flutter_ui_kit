import 'package:change_ui_kit/story_book/props_explorer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../wrap_in_material_app.dart';

void main() {
  group('PropsExplorer', () {
    testWidgets('renders form and widget', (WidgetTester tester) async {
      await tester.pumpWidget(wrapInMaterialApp(PropsExplorer(
        formBuilder: (context, updateProp) => const Text('Form Builder'),
        widgetBuilder: (context, props) => const Text('Widget Builder'),
      )));
      expect(find.text('Form Builder'), findsOneWidget);
      expect(find.text('Widget Builder'), findsOneWidget);
    });

    testWidgets('updateProp updates widget', (WidgetTester tester) async {
      await tester.pumpWidget(wrapInMaterialApp(PropsExplorer(
        formBuilder: (context, updateProp) => TextField(
              onChanged: (String value) {
                updateProp('test', value);
              },
            ),
        widgetBuilder: (context, props) => Text('test: ${props['test']}'),
      )));
      await tester.enterText(find.byType(TextField), 'hello world');
      await tester.pump();
      expect(find.text('test: hello world'), findsOneWidget);
    });
  });
}
