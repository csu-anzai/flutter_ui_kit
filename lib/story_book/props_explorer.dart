import 'package:flutter/material.dart';

typedef PropUpdater = void Function(String name, dynamic value);

typedef WidgetBuilder = Widget Function(
  BuildContext context,
  Map<String, dynamic> props,
);

typedef FormBuilder = Widget Function(
  BuildContext context,
  Map<String, dynamic> props,
  PropUpdater updateProp,
);

class PropsExplorer extends StatefulWidget {
  final WidgetBuilder widgetBuilder;
  final FormBuilder formBuilder;
  final Map<String, dynamic> initialProps;

  PropsExplorer({
    @required this.widgetBuilder,
    @required this.formBuilder,
    this.initialProps,
    Key key,
  })  : assert(widgetBuilder != null),
        assert(formBuilder != null),
        super(key: key);

  @override
  _PropsExplorerState createState() => _PropsExplorerState();
}

class _PropsExplorerState extends State<PropsExplorer> {
  Map<String, dynamic> _props;

  @override
  void initState() {
    _props =
        widget.initialProps != null ? widget.initialProps : <String, dynamic>{};
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        widget.formBuilder(context, _props, _updateProp),
        Divider(),
        widget.widgetBuilder(context, _props),
      ],
    );
  }

  void _updateProp(String name, dynamic value) {
    setState(() {
      final newProps = Map<String, dynamic>.from(_props);
      newProps[name] = value;
      _props = newProps;
    });
  }
}
