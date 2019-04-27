import 'package:flutter/material.dart';
import '../ui/web/web_page.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsItemView extends StatelessWidget {
  final title;
  final time;
  final url;

  NewsItemView(this.title, this.time, this.url);
  
  @override
  Widget build(BuildContext context) {
    timeago.setLocaleMessages('zh_CN', timeago.ZhCnMessages());
    return new Card(
        child: new Container(
            margin: const EdgeInsets.all(12.0),
            child: new ListTile(
              title: new Text(
                title,
                style: new TextStyle(fontSize: 18.0),
              ),
              subtitle: new Text(
                timeago.format(DateTime.parse(time), locale: 'zh_CN'),
                textAlign: TextAlign.right,
                softWrap: true,
              ),
              onTap: () {
                Navigator.of(context).push(new PageRouteBuilder(
                    pageBuilder: (_, __, ___) {
                      return new WebPage(title, url);
                    }));
              },
            )));
  }
}
