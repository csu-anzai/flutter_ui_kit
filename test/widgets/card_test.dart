import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui_kit/color.dart';
import 'package:flutter_ui_kit/widgets/card.dart';

import '../wrap_in_material_app.dart';

void main() {
  group('AppCard', () {
    const underlyingMaterialWidget = Card;

    testWidgets('renders child widget', (WidgetTester tester) async {
      await tester.pumpWidget(wrapInMaterialApp(
          const AppCard(
            child: const Text('Text Content')
          )
        )
      );

      expect(find.text('Text Content'), findsOneWidget);
    });

    testWidgets('sets correct default properteies', (WidgetTester tester) async {
      const child = Text('Text Content');
      await tester.pumpWidget(wrapInMaterialApp(
          const AppCard(
              child: child
          )
        )
      );

      final widget = tester.widget(find.byType(underlyingMaterialWidget));
      final Card cardWidget = widget;
      expect(cardWidget.color, AppColor.deepWhite);
      expect(cardWidget.elevation, 2.0);
      expect(cardWidget.margin, EdgeInsets.zero);
      expect(cardWidget.child, child);
      expect(cardWidget.shape, RoundedRectangleBorder(borderRadius: const BorderRadius.all(const Radius.circular(4.0))));
    });

    testWidgets('passes correct properteies', (WidgetTester tester) async {
      const child = Text('Text Content');
      await tester.pumpWidget(wrapInMaterialApp(
          const AppCard(
              child: child,
              elevation: 4.0,
              margin: EdgeInsets.all(20.0),
              borderRadius: 1,
          )
      )
      );

      final widget = tester.widget(find.byType(underlyingMaterialWidget));
      final Card cardWidget = widget;
      expect(cardWidget.color, AppColor.deepWhite);
      expect(cardWidget.elevation, 4.0);
      expect(cardWidget.margin, const EdgeInsets.all(20.0));
      expect(cardWidget.child, child);
      expect(cardWidget.shape, RoundedRectangleBorder(borderRadius: const BorderRadius.all(const Radius.circular(1.0))));
    });
  });
}
