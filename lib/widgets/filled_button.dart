import 'package:flutter/material.dart';

import 'internal_button.dart';

class FilledButton extends StatelessWidget {
  final Widget child;
  final FutureCallback onPressed;

  FilledButton({
    @required this.child,
    @required this.onPressed,
    Key key,
  })  : assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InternalButton(
      child: child,
      onPressed: onPressed,
      fullWidth: true,
    );
  }
}