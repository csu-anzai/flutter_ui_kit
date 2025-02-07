import 'dart:async';

import 'package:flutter_ui_kit/color.dart';
import 'package:flutter/material.dart';

import 'button_common.dart';

class TwoStatesButton extends StatefulWidget {
  final String initialText;
  final String finalText;
  final int timeIntervalInSec;
  final Function onButtonCallback;
  final FutureCallback onPressed;
  final bool fullWidth;
  final bool narrow;
  final EdgeInsetsGeometry padding;
  final TextStyle textStyle;

  TwoStatesButton(
      this.initialText,
      this.finalText,
      this.timeIntervalInSec,
      { @required this.onButtonCallback,
        @required this.onPressed,
        this.fullWidth = false,
        this.narrow = false,
        this.padding,
        this.textStyle,
        Key key,
      })  : assert(initialText != null),
        super(key: key);

  @override
  _TwoStatesButtonState createState() => _TwoStatesButtonState();
}

class _TwoStatesButtonState extends State<TwoStatesButton> with ButtonMixin {
  bool _enabled = true;
  Timer _timer;
  String _currentText;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    setState(() => _currentText = widget.initialText);
    _timer = new Timer(Duration(seconds: widget.timeIntervalInSec), () {
      setState(() => _currentText = widget.finalText);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.fullWidth ? matchParentWidth(context) : null,
      child: RaisedButton(
        child: Text(
          _currentText,
          style: (widget.textStyle != null) ? widget.textStyle :
          Theme.of(context).textTheme.body1.copyWith(
              color: AppColor.deepWhite,
              fontSize: getFontSize(narrow: widget.narrow, fullWidth: widget.fullWidth)
          ),
        ),
        onPressed: isDisabled(enabled: _enabled, onPressed: widget.onPressed)
            ? null
            : () {

          if (_timer.isActive) {
            disableButtonWhileOnPressedExecutes(
                setEnabled: _setEnabled, onPressed: widget.onPressed);
          } else {
            _startTimer();
            widget.onButtonCallback();
          }
        },
        padding: widget.padding ?? getPadding(narrow: widget.narrow),
        elevation: 0.0,
        highlightElevation: 0.0,
        disabledElevation: 0.0,
        textColor: AppColor.deepWhite,
        disabledTextColor: AppColor.deepWhite,
        disabledColor: AppColor.mediumGrey,
        highlightColor: AppColor.darkerGreen,
      ),
    );
  }

  void _setEnabled(bool enabled) {
    if (_enabled != enabled) {
      setState(() => _enabled = enabled);
    }
  }
}
