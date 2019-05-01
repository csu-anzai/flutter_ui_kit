import 'package:flutter/material.dart';

import '../color.dart';

class AppCard extends StatelessWidget {

  const AppCard({
    Key key,
    this.child,
    this.margin = const EdgeInsets.all(0.0),
    this.color = AppColor.deepWhite,
    this.elevation = 2.0,
    this.borderRadius = 4.0
  }) : super(key: key);

  final Color color;
  final double elevation;
  final EdgeInsetsGeometry margin;
  final Widget child;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: child,
      margin: margin,
      color: color,
      elevation: elevation,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(borderRadius)))
    );
  }
}
