import 'package:flutter_ui_kit/color.dart';
import 'package:flutter/material.dart';

import 'button_common.dart';

class PlainButton extends StatefulWidget {
  final String text;
  final FutureCallback onPressed;
  final bool narrow;

  PlainButton(
    this.text, {
    @required this.onPressed,
    this.narrow = false,
    Key key,
  })  : assert(text != null),
        super(key: key);

  @override
  _PlainButtonState createState() => _PlainButtonState();
}

class _PlainButtonState extends State<PlainButton> with ButtonMixin {
  bool _enabled = true;
  bool _pressing = false;

  @override
  Widget build(BuildContext context) {
    return _buildButton();
  }

  Widget _buildButton() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTapDown: (_) {
          setState(() => _pressing = true);
        },
        onTapCancel: () {
          setState(() => _pressing = false);
        },
        child: FlatButton(
          child: Text(
            widget.text,
            style: TextStyle(
              color: getTextColorOnWhiteBackground(
                enabled: _enabled,
                pressing: _pressing,
                onPressed: widget.onPressed,
              ),
              fontSize: ButtonStyleConstants.fontSize,
            ),
          ),
          onPressed: isDisabled(enabled: _enabled, onPressed: widget.onPressed)
              ? null
              : () => disableButtonWhileOnPressedExecutes(
                  setEnabled: _setEnabled, onPressed: widget.onPressed),
          padding: getPadding(narrow: widget.narrow),
          textColor: AppColor.green,
        ),
      ),
    );
  }

  void _setEnabled(bool enabled) {
    setState(() => _enabled = enabled);
  }
}
