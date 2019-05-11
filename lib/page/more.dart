import 'package:flutter/material.dart';
import '../model/more_model.dart';

class More extends StatefulWidget {
  @override
  _MoreState createState() => _MoreState();

}

class _MoreState extends State<More> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return new ListPage(title: 'mores');
  }
}

class ListPage extends StatefulWidget {
  ListPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List mores;

  @override
  void initState() {
    mores = getMore();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ListTile makeListTile(MoreMdel more) => ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.white24))),
            child: more.icon,
          ),
          title: Text(
            more.title,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          trailing: Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
          onTap: () {
            Navigator.pushNamed(context, more.path);
          },
        );

    Card makeCard(MoreMdel more) => Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: makeListTile(more),
      ),
    );

    final makeBody = Container(
      // decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: mores.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(mores[index]);
        },
      ),
    );

    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      body: makeBody,
    );
  }
}

List getMore() {
  return [
    // MoreMdel(
    //     title: "天气预报",
    //     icon: Icon(Icons.account_balance, color: Colors.white),
    //     path: '/weather'
    // ),
    MoreMdel(
      title: '随机图片',
      icon: Icon(Icons.scanner, color: Colors.white),
      path: '/rand_image'
    )
  ];
}