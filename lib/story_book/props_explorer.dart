import 'package:flutter/material.dart';

typedef PropUpdater = void Function(String name, dynamic value);

typedef WidgetBuilder = Widget Function(
  Map<String, dynamic> props,
  BuildContext context,
);

typedef FormBuilder = Widget Function(
  PropUpdater updateProp,
  BuildContext context,
);

class PropsExplorer extends StatefulWidget {
  final WidgetBuilder widgetBuilder;
  final FormBuilder formBuilder;

  PropsExplorer({
    @required this.widgetBuilder,
    @required this.formBuilder,
    Key key,
  })  : assert(widgetBuilder != null),
        assert(formBuilder != null),
        super(key: key);

  @override
  _PropsExplorerState createState() => _PropsExplorerState();
}

class _PropsExplorerState extends State<PropsExplorer> {
  Map<String, dynamic> props = <String, dynamic>{};

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        widget.formBuilder(_updateProp, context),
        widget.widgetBuilder(props, context),
      ],
    );
  }

  void _updateProp(String name, dynamic value) {
    setState(() {
      final newProps = Map<String, dynamic>.from(props);
      newProps[name] = value;
      props = newProps;
    });
  }
}
