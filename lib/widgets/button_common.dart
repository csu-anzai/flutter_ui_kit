import 'package:flutter/material.dart';

typedef FutureCallback = Future<void> Function();

typedef EnabledSetter = void Function(bool enabled);

class ButtonPadding {
  static const EdgeInsetsGeometry narrowPadding =
      const EdgeInsets.symmetric(vertical: 11.5, horizontal: 48.0);
  static const EdgeInsetsGeometry widePadding =
      const EdgeInsets.symmetric(vertical: 17.5, horizontal: 48.0);
}

mixin ButtonMixin {
  Container wrapInFullWidthContainer(BuildContext context, Widget child) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: child,
    );
  }

  EdgeInsetsGeometry getPadding({bool narrow = false}) {
    return narrow ? ButtonPadding.narrowPadding : ButtonPadding.widePadding;
  }

  bool isDisabled({
    bool enabled,
    FutureCallback onPressed,
  }) {
    return !enabled || onPressed == null;
  }

  Future<void> handlePress({
    EnabledSetter setEnabled,
    FutureCallback onPressed,
  }) async {
    setEnabled(false);
    await onPressed();
    setEnabled(true);
  }
}
