import 'package:change_ui_kit/stories/buttons.dart';
import 'package:change_ui_kit/stories/colors.dart';
import 'package:change_ui_kit/theme.dart';
import 'package:flutter/material.dart';
import 'package:storyboard/storyboard.dart';

void main() {
  runApp(
    MaterialApp(
      theme: theme,
      home: Storyboard([
        AppColors(),
        Buttons(),
      ]),
    ),
  );
}
