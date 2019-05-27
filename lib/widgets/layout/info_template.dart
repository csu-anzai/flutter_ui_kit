import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_ui_kit/widgets/layout/page_template.dart';
import 'package:flutter_ui_kit/widgets/text/heading.dart';

import 'app_bar.dart';

class InfoTemplate extends StatelessWidget {
  final bool info;
  final Heading header;
  final Widget child;
  final Widget action;
  final String routeName;
  final SvgPicture picture;


  const InfoTemplate(this.header, this.child, this.action,
      {this.info = false, this.routeName, this.picture})
      : super();

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      appBar: MainAppBar(
          implyLeading: info, leadingWidget: _getInfoButton(context)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: header,
            ),
            Expanded(flex: 1, child: child),
            Expanded(
              flex:2,
              child: Align(
                alignment: Alignment.topCenter,
                child: picture,
              ),
            ),
            Expanded(
              flex:1,
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: action,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _getInfoButton(BuildContext context) {
    if (info) {
      return IconButton(icon: const Icon(Icons.info_outline),
          onPressed: () {
            Navigator.popAndPushNamed(context, routeName);
          });
    }
    return null;
  }
}