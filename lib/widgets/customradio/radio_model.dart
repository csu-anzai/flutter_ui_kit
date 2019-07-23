import 'package:flutter_svg/flutter_svg.dart';

class RadioModel {
  bool isSelected;
  final String text;
  SvgPicture svgPicture;
  final String textShortform;
  RadioModel(this.text, {this.svgPicture, this.isSelected, this.textShortform});
}