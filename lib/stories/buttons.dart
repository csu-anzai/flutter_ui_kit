import 'package:change_ui_kit/story_book/props_explorer.dart';
import 'package:change_ui_kit/story_book/story.dart';
import 'package:change_ui_kit/story_book/story_page.dart';
import 'package:change_ui_kit/widgets/filled_button.dart';
import 'package:flutter/material.dart';

class Buttons extends StoryPage {
  @override
  List<Widget> get storyContent {
    return [
      _buttonStory(ButtonType.filled),
      _buttonStory(ButtonType.outlined),
    ];
  }

  Widget _buttonStory(ButtonType buttonType) {
    return Story(
      title: buttonType == ButtonType.filled ? 'Filled Button' : 'Outlined Button',
      child: PropsExplorer(
        formBuilder: (context, props, updateProp) {
          return ListView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: 'Title',
                  hintText: 'Button',
                ),
                onChanged: (String value) {
                  updateProp('title', value);
                },
              ),
              SwitchListTile(
                title: const Text('Enabled'),
                value: props['enabled'] ?? true,
                onChanged: (bool value) {
                  updateProp('enabled', value);
                },
              ),
              SwitchListTile(
                title: const Text('Full width'),
                value: props['fullWidth'] ?? true,
                onChanged: (bool value) {
                  updateProp('fullWidth', value);
                },
              ),
              SwitchListTile(
                title: const Text('Narrow'),
                value: props['narrow'] ?? false,
                onChanged: (bool value) {
                  updateProp('narrow', value);
                },
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Simulate task with duration in milliseconds',
                  hintText: '1000',
                ),
                keyboardType: TextInputType.number,
                onChanged: (String value) {
                  updateProp('taskDuration', value);
                },
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
                  Duration(milliseconds: int.tryParse(props['taskDuration'])));
            };
          }

          if (buttonType == ButtonType.filled) {
            return FilledButton(
              child: Text(props['title'] ?? 'Button'),
              onPressed: onPressed,
              fullWidth: props['fullWidth'] ?? true,
              narrow: props['narrow'] ?? false,
            );
          } else {
            return FilledButton(
              child: Text(props['title'] ?? 'Button'),
              onPressed: onPressed,
              fullWidth: props['fullWidth'] ?? true,
              narrow: props['narrow'] ?? false,
            );
          }
        },
      ),
    );
  }
}

enum ButtonType {
  filled,
  outlined,
}
