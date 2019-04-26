import 'package:flutter_ui_kit/story_book/prop_updater/bool_prop_updater.dart';
import 'package:flutter_ui_kit/story_book/prop_updater/int_prop_updater.dart';
import 'package:flutter_ui_kit/story_book/prop_updater/string_prop_updater.dart';
import 'package:flutter_ui_kit/story_book/props_explorer.dart';
import 'package:flutter_ui_kit/story_book/story.dart';
import 'package:flutter_ui_kit/story_book/story_page.dart';
import 'package:flutter_ui_kit/widgets/filled_button.dart';
import 'package:flutter_ui_kit/widgets/outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui_kit/widgets/plain_button.dart';

class Buttons extends StoryPage {
  @override
  List<Widget> get storyContent {
    return [
      _filledButtonStory(),
      _outlinedButtonStory(),
      _plainButtonStory(),
    ];
  }

  Widget _filledButtonStory() {
    return Story(
      title: 'Filled Button',
      child: PropsExplorer(
        initialProps: const <String, dynamic>{
          'text': 'Activate',
          'enabled': true,
          'fullWidth': true,
          'narrow': false,
          'taskDuration': 300,
        },
        formBuilder: (context, props, updateProp) {
          return ListView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: <Widget>[
              StringPropUpdater(
                props: props,
                updateProp: updateProp,
                propKey: 'text',
              ),
              BoolPropUpdater(
                props: props,
                updateProp: updateProp,
                propKey: 'enabled',
              ),
              BoolPropUpdater(
                props: props,
                updateProp: updateProp,
                propKey: 'fullWidth',
              ),
              BoolPropUpdater(
                props: props,
                updateProp: updateProp,
                propKey: 'narrow',
              ),
              IntPropUpdater(
                props: props,
                updateProp: updateProp,
                propKey: 'taskDuration',
                hintText: 'Simulate task with duration in milliseconds',
              ),
            ],
          );
        },
        widgetBuilder: (context, props) {
          Function onPressed = () {};

          if (props['enabled'] == false) {
            onPressed = null;
          }

          if (props['taskDuration'] != null && props['enabled'] != false) {
            onPressed = () async {
              await Future<void>.delayed(
                  Duration(milliseconds: props['taskDuration']));
            };
          }

          return FilledButton(
            props['text'],
            onPressed: onPressed,
            fullWidth: props['fullWidth'],
            narrow: props['narrow'],
          );
        },
      ),
    );
  }

  Widget _outlinedButtonStory() {
    return Story(
      title: 'Outlined Button',
      child: PropsExplorer(
        initialProps: const <String, dynamic>{
          'text': 'Activate',
          'enabled': true,
          'fullWidth': true,
          'narrow': false,
          'taskDuration': 300,
        },
        formBuilder: (context, props, updateProp) {
          return ListView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: <Widget>[
              StringPropUpdater(
                props: props,
                updateProp: updateProp,
                propKey: 'text',
              ),
              BoolPropUpdater(
                props: props,
                updateProp: updateProp,
                propKey: 'enabled',
              ),
              BoolPropUpdater(
                props: props,
                updateProp: updateProp,
                propKey: 'fullWidth',
              ),
              BoolPropUpdater(
                props: props,
                updateProp: updateProp,
                propKey: 'narrow',
              ),
              IntPropUpdater(
                props: props,
                updateProp: updateProp,
                propKey: 'taskDuration',
                hintText: 'Simulate task with duration in milliseconds',
              ),
            ],
          );
        },
        widgetBuilder: (context, props) {
          Function onPressed = () {};

          if (props['enabled'] == false) {
            onPressed = null;
          }

          if (props['taskDuration'] != null && props['enabled'] != false) {
            onPressed = () async {
              await Future<void>.delayed(
                  Duration(milliseconds: props['taskDuration']));
            };
          }

          return OutlinedButton(
            props['text'],
            onPressed: onPressed,
            fullWidth: props['fullWidth'],
            narrow: props['narrow'],
          );
        },
      ),
    );
  }

  Widget _plainButtonStory() {
    return Story(
      title: 'Plain Button',
      child: PropsExplorer(
        initialProps: const <String, dynamic>{
          'text': 'Activate',
          'enabled': true,
          'narrow': false,
          'taskDuration': 300,
        },
        formBuilder: (context, props, updateProp) {
          return ListView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: <Widget>[
              StringPropUpdater(
                props: props,
                updateProp: updateProp,
                propKey: 'text',
              ),
              BoolPropUpdater(
                props: props,
                updateProp: updateProp,
                propKey: 'enabled',
              ),
              BoolPropUpdater(
                props: props,
                updateProp: updateProp,
                propKey: 'narrow',
              ),
              IntPropUpdater(
                props: props,
                updateProp: updateProp,
                propKey: 'taskDuration',
                hintText: 'Simulate task with duration in milliseconds',
              ),
            ],
          );
        },
        widgetBuilder: (context, props) {
          Function onPressed = () {};

          if (props['enabled'] == false) {
            onPressed = null;
          }

          if (props['taskDuration'] != null && props['enabled'] != false) {
            onPressed = () async {
              await Future<void>.delayed(
                  Duration(milliseconds: props['taskDuration']));
            };
          }

          return PlainButton(
            props['text'],
            onPressed: onPressed,
            narrow: props['narrow'],
          );
        },
      ),
    );
  }
}
