import 'package:flutter/material.dart';
import 'package:flutter_ui_kit/widgets.dart';
import 'package:flutter_ui_kit/widgets/layout/app_bar.dart';
import 'package:flutter_ui_kit/widgets/layout/page_template.dart';
import 'package:flutter_ui_kit/widgets/simple_progress_indicator.dart';
import 'package:flutter_ui_kit/widgets/wizzard/wizard_binder.dart';

import '../filled_button.dart';

class Wizard extends StatefulWidget {
  final WizardBinder binder;
  final Widget intoWidget;
  final List<Widget> wizardPages;
  final Widget outroWidget;

  const Wizard(
      {this.intoWidget, this.wizardPages, this.outroWidget, this.binder});

  @override
  _WizardState createState() =>
      _WizardState(intoWidget, wizardPages, outroWidget, binder);
}

class _WizardState extends State<Wizard> {
  WizardBinder binder;
  int currentPage = -1;

  Widget introWidget;
  List<Widget> wizardPages;
  Widget outroWidget;
  final List<int> skippedPages = [];

  Widget leadingWidget = const BackButton();
  List<Widget> tailingWidget;

  _WizardState(
      this.introWidget, this.wizardPages, this.outroWidget, this.binder);

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      appBar: MainAppBar(
          implyLeading: leadingWidget != null,
          leadingWidget: leadingWidget,
          tailingWidget: [_doThisLater()]),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Expanded(flex: 1, child: _getCurrentPage()),
            FilledButton(_callToActionText(), fullWidth: true, onPressed: () {
              setState(() {
                _callToActionEvent();
                currentPage++;
              });
            }),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 10.0, right: 10),
              child: Container(
                  alignment: Alignment.bottomCenter,
                  child: _saveProgressIndicatorState()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _doThisLater() {
    if (currentPage >= 0 && currentPage <= wizardPages.length) {
      return TextButton('Do this later', onPressed: () {
      });
    }
    return TextButton('');
  }

  Widget _saveProgressIndicatorState() {
    if (currentPage >= 0 && currentPage <= wizardPages.length) {
      return SimpleProgressIndicator(
        height: 3,
        percentageFilled: currentPage / wizardPages.length * 100,
      );
    }
    return const SimpleProgressIndicator(
      percentageFilled: 0,
    );
  }

  void _callToActionEvent() {
    if (currentPage < 0) {
      return binder.onStart();
    } else if (currentPage >= wizardPages.length) {
      return binder.onEnd();
    } else {
      binder.onNext(currentPage);
    }
  }

  String _callToActionText() {
    final text = binder.getCallToAction(currentPage);
    if (text == null) {
      if (currentPage < 0) {
        return 'Create account';
      } else if (currentPage == wizardPages.length) {
        return 'End';
      } else {
        return 'Next';
      }
    } else {
      return text;
    }
  }

  Widget _getCurrentPage() {
    if (currentPage < 0) {
      debugPrint('Showing intro wizard');
      return introWidget;
    } else if (currentPage >= wizardPages.length) {
      debugPrint('Showing outro wizard');
      return outroWidget;
    } else {
      debugPrint('Showing wizard page[$currentPage]');
      return wizardPages[currentPage];
    }
  }
}
