import 'package:flutter/material.dart';
import 'package:flutter_ui_kit/color.dart';

typedef FutureCallback = Future<void> Function();

typedef EnabledSetter = void Function(bool enabled);

class ButtonStyleConstants {
  static const EdgeInsetsGeometry narrowPadding =
      const EdgeInsets.symmetric(vertical: 11.5, horizontal: 48.0);
  static const EdgeInsetsGeometry widePadding =
      const EdgeInsets.symmetric(vertical: 17.5, horizontal: 48.0);
  static const double fontSize = 16.0;
}

mixin ButtonMixin {
  double matchParentWidth(BuildContext context) => MediaQuery.of(context).size.width;

  EdgeInsetsGeometry getPadding({bool narrow = false}) {
    return narrow ? ButtonStyleConstants.narrowPadding : ButtonStyleConstants.widePadding;
  }

  bool isDisabled({
    bool enabled,
    FutureCallback onPressed,
  }) {
    return !enabled || onPressed == null;
  }

  Color getTextColorOnWhiteBackground({bool enabled, bool pressing, FutureCallback onPressed}) {
    if (isDisabled(enabled: enabled, onPressed: onPressed)) {
      return AppColor.mediumGrey;
    }
    return pressing ? AppColor.darkerGreen : AppColor.green;
  }


  Future<void> disableButtonWhileOnPressedExecutes({
    EnabledSetter setEnabled,
    FutureCallback onPressed,
  }) async {
    setEnabled(false);
    await onPressed();
    setEnabled(true);
  }
}
