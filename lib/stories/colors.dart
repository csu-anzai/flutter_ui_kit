import 'package:change_ui_kit/story_book/story_page.dart';
import 'package:change_ui_kit/story_book/story_group.dart';
import 'package:flutter/material.dart';

import '../color.dart';

class AppColors extends StoryPage {
  @override
  List<Widget> get storyContent {
    return [
      StoryGroup(
        title: 'Primary Colors',
        children: <Widget>[
          const ColorInfoBox(
            color: AppColor.green,
            name: 'Green',
            usage: 'Button & Text Button',
          ),
          ColorInfoBox(
            color: AppColor.paleGreen,
            name: 'Pale Green 20%',
            usage: 'Disabled Text Button',
          ),
        ],
      ),
      StoryGroup(
        title: 'Accent Colors',
        children: const <Widget>[
          ColorInfoBox(
            color: AppColor.deepBlack,
            name: 'Deep Black',
            usage: 'Heading, Important Text & Icons',
          ),
          ColorInfoBox(
            color: AppColor.deepWhite,
            name: 'deepWhite',
            usage: 'Background',
          ),
        ],
      ),
      StoryGroup(
        title: 'Semantic Colors',
        children: const <Widget>[
          ColorInfoBox(
            color: AppColor.red,
            name: 'Red',
            usage: 'Error Text',
          ),
          ColorInfoBox(
            color: AppColor.brightGreen,
            name: 'Green success',
            usage: 'Success',
          ),
        ],
      ),
      StoryGroup(
        title: 'Grey colors',
        children: const <Widget>[
          ColorInfoBox(
            color: AppColor.lightestGrey,
            name: 'Lightest grey',
            usage: 'Dividers & Failed Transactions',
          ),
          ColorInfoBox(
            color: AppColor.grey,
            name: 'Grey',
            usage: 'Placeholder',
          ),
          ColorInfoBox(
            color: AppColor.mediumGrey,
            name: 'Medium Grey',
            usage: 'Disables buttons',
          ),
          ColorInfoBox(
            color: AppColor.semiGrey,
            name: 'Semi Grey',
            usage: 'Text & Icons',
          ),
        ],
      ),
    ];
  }
}

class ColorInfoBox extends StatelessWidget {
  final Color color;
  final String name;
  final String usage;

  const ColorInfoBox({this.color, this.name, this.usage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: <Widget>[
          Container(
            width: 100.0,
            height: 100.0,
            color: color,
          ),
          Container(
            width: 100.0,
            child: Text(name),
          ),
          Container(
            width: 100.0,
            child: Text('Usage: $usage'),
          ),
        ],
      ),
    );
  }
}
