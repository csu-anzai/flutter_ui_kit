import 'package:change_ui_kit/story_book/story.dart';
import 'package:change_ui_kit/story_book/story_page.dart';
import 'package:change_ui_kit/widgets/button.dart';
import 'package:flutter/material.dart';

class Buttons extends StoryPage {
  @override
  List<Widget> get storyContent {
    return [
      Story(
        title: 'Large Filled Button',
        child: FlatButton(child: Text('Coming soon')),
      )
    ];
  }
}
