import 'package:flutter_ui_kit/color.dart';
import 'package:flutter/material.dart';

import 'button_common.dart';

class OutlinedButton extends StatefulWidget {
  final String text;
  final FutureCallback onPressed;
  final bool fullWidth;
  final bool narrow;

  OutlinedButton(
    this.text, {
    @required this.onPressed,
    this.fullWidth = true,
    this.narrow = false,
    Key key,
  })  : assert(text != null),
        super(key: key);

  @override
  _OutlinedButtonState createState() => _OutlinedButtonState();
}

class _OutlinedButtonState extends State<OutlinedButton> with ButtonMixin {
  bool _enabled = true;
  bool _pressing = false;

  @override
  Widget build(BuildContext context) {
    if (widget.fullWidth) {
      return wrapInFullWidthContainer(context, _buildButton());
    }
    return _buildButton();
  }

  Widget _buildButton() {
    return GestureDetector(
      onTapDown: (_) {
        setState(() => _pressing = true);
      },
      onTapCancel: () {
        setState(() => _pressing = false);
      },
      child: OutlineButton(
        child: Text(
          widget.text,
          style: TextStyle(
            color: _getTextColor(),
            fontSize: ButtonStyleConstants.fontSize,
          ),
        ),
        onPressed: isDisabled(enabled: _enabled, onPressed: widget.onPressed)
            ? null
            : () => disableButtonWhileOnPressedExecutes(
                setEnabled: _setEnabled, onPressed: widget.onPressed),
        padding: getPadding(narrow: widget.narrow),
        textColor: AppColor.green,
        borderSide: BorderSide(color: AppColor.green),
        highlightedBorderColor: AppColor.green,
        disabledBorderColor: AppColor.mediumGrey,
      ),
    );
  }

  void _setEnabled(bool enabled) {
    setState(() => _enabled = enabled);
  }

  Color _getTextColor() {
    if (isDisabled(enabled: _enabled, onPressed: widget.onPressed)) {
      return AppColor.mediumGrey;
    }
    return _pressing ? AppColor.darkerGreen : AppColor.green;
  }
}
