import 'package:flutter_ui_kit/story_book/expandable_story.dart';
import 'package:flutter_ui_kit/story_book/prop_updater/bool_prop_updater.dart';
import 'package:flutter_ui_kit/story_book/prop_updater/int_prop_updater.dart';
import 'package:flutter_ui_kit/story_book/prop_updater/string_prop_updater.dart';
import 'package:flutter_ui_kit/story_book/props_explorer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui_kit/widgets/form_fields/pin_field.dart';

class FormFields extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _pinFieldsStory(),
        ],
      ),
    );
  }

  Widget _pinFieldsStory() {
    return ExpandableStory(
      title: 'Pin Field',
      child: PropsExplorer(
        initialProps: const <String, dynamic>{
          'fieldsCount': 3,
          'errorMessage': '',
          'autofocus': true
        },
        formBuilder: (context, props, updateProp) {
          return ListView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: <Widget>[
              IntPropUpdater(
                props: props,
                updateProp: updateProp,
                propKey: 'fieldsCount',
                hintText: 'number of fields',
              ),
              StringPropUpdater(
                props: props,
                updateProp: updateProp,
                propKey: 'errorMessage',
                hintText: 'error message',
              ),
              BoolPropUpdater(
                props: props,
                updateProp: updateProp,
                propKey: 'autofocus',
              ),
            ],
          );
        },
        widgetBuilder: (context, props) {
          return Center(
            child: PinField(
              fieldsCount: props['fieldsCount'],
              errorMessage: props['errorMessage'],
              autofocus: props['autofocus'],
              onSubmit: (String pin) => _showSnackBar(pin, context),
            ),
          );
        },
      ),
    );
  }

  Future<void> _showSnackBar(String pin, BuildContext context) async {
    final snackBar = SnackBar(
      duration: Duration(seconds: 5),
      content: Container(
          height: 80.0,
          child: Center(
            child: Text(
              'Pin Submitted. Value: $pin',
              style: TextStyle(fontSize: 25.0),
            ),
          )),
      backgroundColor: Colors.greenAccent,
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
