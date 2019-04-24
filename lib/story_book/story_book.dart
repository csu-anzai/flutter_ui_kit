import 'package:change_ui_kit/story_book/story_page.dart';
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';

class StoryBook extends StatelessWidget {
  final List<StoryPage> pages;
  final String title;

  StoryBook({
    @required this.pages,
    this.title,
  })  : assert(pages != null),
        super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(title ?? 'Story Book')),
        body: ListView.builder(
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) =>
              _pageOpener(context, pages[index]),
          itemCount: pages.length,
        ));
  }

  ListTile _pageOpener(BuildContext context, StoryPage page) {
    final title = _getTitle(page);
    final titleWidget = Text(title);
    return ListTile(
        trailing: const Icon(Icons.arrow_right),
        title: titleWidget,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute<Null>(builder: (BuildContext context) {
              return Scaffold(
                appBar: AppBar(title: titleWidget),
                body: page,
              );
            }),
          );
        });
  }

  String _getTitle(StoryPage page) =>
      ReCase(page.runtimeType.toString()).titleCase;
}
