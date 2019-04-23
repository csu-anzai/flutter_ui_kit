import 'package:change_ui_kit/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:storyboard/storyboard.dart';

import '../color.dart';

class ColorBox extends StatelessWidget {
  final Color color;

  ColorBox(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
      height: 100.0,
      color: color,
    );
  }
}
class AppColors extends Story {
  @override
  List<Widget> get storyContent {
    return [
      ColorBox(AppColor.green),
    ];
  }
}