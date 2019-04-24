import 'package:flutter/material.dart';

class InternalButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;

  InternalButton({
    Key key,
    @required this.child,
    @required this.onPressed,
  })  : assert(child != null),
        assert(onPressed != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: child,
      onPressed: onPressed,
    );
  }
}
