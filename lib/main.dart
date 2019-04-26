import 'package:flutter_ui_kit/stories/buttons.dart';
import 'package:flutter_ui_kit/stories/colors.dart';
import 'package:flutter_ui_kit/story_book/story_book.dart';
import 'package:flutter_ui_kit/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      theme: theme,
      home: StoryBook(
        title: 'Change UI Components',
        pages: [
          AppColors(),
          Buttons(),
        ],
      ),
    ),
  );
}
