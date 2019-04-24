import 'package:flutter/material.dart';

import '../color.dart';

typedef FutureCallback = Future<void> Function();

class InternalButton extends StatefulWidget {
  final Widget child;
  final FutureCallback onPressed;
  bool fullWidth;

  InternalButton({
    @required this.child,
    @required this.onPressed,
    this.fullWidth = true,
    Key key,
  })  : assert(child != null),
        super(key: key);

  @override
  _InternalButtonState createState() => _InternalButtonState();
}

class _InternalButtonState extends State<InternalButton> {
  bool _enabled = true;

  @override
  Widget build(BuildContext context) {
    if (widget.fullWidth) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: _buildButton(context),
      );
    }
    return _buildButton(context);
  }

  Widget _buildButton(BuildContext context) {
    return RaisedButton(
      child: widget.child,
      onPressed: _disabled() ? null : _handlePress,
      elevation: 0.0,
      highlightElevation: 0.0,
      disabledElevation: 0.0,
      textColor: AppColor.deepWhite,
    );
  }

  bool _disabled() => !_enabled || widget.onPressed == null;

  Future<void> _handlePress() async {
    _setEnabled(false);
    await widget.onPressed();
    _setEnabled(true);
  }

  void _setEnabled(bool enabled) {
    if (_enabled != enabled) {
      setState(() => _enabled = enabled);
    }
  }
}
