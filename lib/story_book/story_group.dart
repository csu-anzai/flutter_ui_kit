import 'package:flutter/material.dart';

class StoryGroup extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const StoryGroup({
    @required this.children,
    @required this.title,
  })  : assert(children != null),
        assert(title != null),
        super();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(title),
        horizontalList(children),
      ],
    );
  }

  SingleChildScrollView horizontalList(List<Widget> children) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}
