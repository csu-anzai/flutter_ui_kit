import 'package:flutter/material.dart';

typedef FutureCallback = Future<void> Function();

class InternalButton extends StatefulWidget {
  final Widget child;
  final FutureCallback onPressed;

  InternalButton({
    @required this.child,
    @required this.onPressed,
    Key key,
  })  : assert(child != null),
        assert(onPressed != null),
        super(key: key);

  @override
  _InternalButtonState createState() => _InternalButtonState();
}

class _InternalButtonState extends State<InternalButton> {
  bool _enabled = true;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: widget.child,
      onPressed: _enabled ? _handlePress : null,
    );
  }

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
