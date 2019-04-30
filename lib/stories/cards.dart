import 'package:flutter/material.dart';
import 'package:flutter_ui_kit/color.dart';
import 'package:flutter_ui_kit/story_book/prop_updater/double_prop_updater.dart';
import 'package:flutter_ui_kit/story_book/props_explorer.dart';
import 'package:flutter_ui_kit/story_book/story.dart';
import 'package:flutter_ui_kit/widgets/card.dart';
import 'package:flutter_ui_kit/widgets/text_button.dart';

class AppCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            _dialogCardStory(),
          ],
        ),
      ),
    );
  }

  Widget _dialogCardStory() {
    return Story(
      title: 'Card',
      child: PropsExplorer(
      initialProps: const <String, dynamic>{
        'elevation': 5.0,
        'margin': 15.0,
        'borderRadius': 4.0,
      },
      formBuilder: (context, props, updateProp) {
        return ListView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: <Widget>[
            DoublePropUpdater(
              props: props,
              updateProp: updateProp,
              propKey: 'elevation',
              min: 0,
              max: 20
            ),
            DoublePropUpdater(
              props: props,
              updateProp: updateProp,
              propKey: 'margin',
              min: 0,
              max: 20
            ),
            DoublePropUpdater(
              props: props,
              updateProp: updateProp,
              propKey: 'borderRadius',
              min: 0,
              max: 20
            )
          ],
        );
      },
      widgetBuilder: (context, props) {
        final double elevation = props['elevation'];
        final double margin = props['margin'];
        final double borderRadius = props['borderRadius'];

        return AppCard(
          color: AppColor.deepWhite,
          elevation: elevation,
          margin: EdgeInsets.all(margin),
          borderRadius: borderRadius,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                leading: Icon(Icons.album),
                title: Text('The Enchanted Nightingale'),
                subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
              ),
              ButtonTheme.bar(
                child: ButtonBar(
                  children: <Widget>[
                    TextButton(
                      'BUY TICKETS',
                      onPressed: (){},
                    ),
                    TextButton(
                      'LISTEN',
                      onPressed: (){},
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    ),
    );
  }
}
