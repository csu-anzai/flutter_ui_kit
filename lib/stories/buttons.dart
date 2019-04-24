import 'package:change_ui_kit/story_book/story.dart';
import 'package:change_ui_kit/story_book/story_page.dart';
import 'package:change_ui_kit/widgets/filled_button.dart';
import 'package:flutter/material.dart';

class Buttons extends StoryPage {
  @override
  List<Widget> get storyContent {
    return [
      Story(
        title: 'Large Filled Button',
        child: Column(
          children: <Widget>[
            FilledButton(
              child: const Text('Activate'),
              onPressed: () async {
                await Future<void>.delayed(const Duration(seconds: 1));
              },
            ),
            Divider(),
            FilledButton(
              child: const Text('Activate'),
              onPressed: null,
            ),
          ],
        ),
      ),
      Story(
        title: 'Large Narrow Button',
        child: Column(
          children: <Widget>[
            FilledButton(
              child: const Text('Activate'),
              onPressed: () async {
                await Future<void>.delayed(const Duration(seconds: 1));
              },
            ),
            Divider(),
            FilledButton(
              child: const Text('Activate'),
              onPressed: null,
            ),
          ],
        ),
      ),
    ];
  }
}
