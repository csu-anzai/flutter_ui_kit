import 'package:flutter/material.dart';
import 'package:flutter_ui_kit/color.dart';
import 'package:flutter_ui_kit/story_book/prop_updater/int_prop_updater.dart';
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
        'elevation': 5,
        'margin': 15,
        'borderRadius': 4,
      },
      formBuilder: (context, props, updateProp) {
        return ListView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: <Widget>[
            IntPropUpdater(
              props: props,
              updateProp: updateProp,
              propKey: 'elevation',
            ),
            IntPropUpdater(
              props: props,
              updateProp: updateProp,
              propKey: 'margin',
            ),
            IntPropUpdater(
              props: props,
              updateProp: updateProp,
              propKey: 'borderRadius',
            )
          ],
        );
      },
      widgetBuilder: (context, props) {
        final int elevation = props['elevation'];
        final int margin = props['margin'];
        final int borderRadius = props['borderRadius'];

        return AppCard(
          color: AppColor.deepWhite,
          elevation: elevation.toDouble(),
          margin: EdgeInsets.all(margin.toDouble()),
          borderRadius: borderRadius.toDouble(),
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
