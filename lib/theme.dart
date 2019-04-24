import 'package:flutter/material.dart';

import 'color.dart';

final ThemeData theme = ThemeData(
  brightness: Brightness.light,
  primaryColor: primaryColor,
  primarySwatch: AppColor.greenSwatch,
  canvasColor: AppColor.deepWhite,
  backgroundColor: AppColor.deepWhite,
  scaffoldBackgroundColor: AppColor.deepWhite,
  disabledColor: AppColor.mediumGrey,
  buttonTheme: _buttonTheme,
);

const Color primaryColor = AppColor.green;

ButtonThemeData _buttonTheme = ButtonThemeData(
  textTheme: ButtonTextTheme.primary,
  buttonColor: primaryColor,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
);
