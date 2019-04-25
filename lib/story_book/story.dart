import 'package:flutter/material.dart';

class Story extends StatelessWidget {
  final String title;
  final Widget child;

  const Story({
    @required this.child,
    @required this.title,
  })  : assert(child != null),
        assert(title != null),
        super();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(title),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: child,
        ),
      ],
    );
  }
}
