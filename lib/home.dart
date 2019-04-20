import 'package:flutter/material.dart';
import './page/bing_picture.dart';
import './page/daily_one.dart';
import './page/readhub/app.dart';

class HomePageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePageWidget> {
  int _tabIndex = 0;

  var _bodys, _titles;

  void initData() {
    _bodys = [
      new ReadHubApp(),
      new BingPicture(),
      new DailyOne(),
    ];
    _titles = [
      new Text("readhub"),
      new Text("必应图片"),
      new Text("每日一句"),
    ];
  }

  @override
  Widget build(BuildContext context) {
    initData();
    return Scaffold(
      appBar: new AppBar(
        title: _titles[_tabIndex],
      ),
      body: _bodys[_tabIndex],
      bottomNavigationBar: new BottomNavigationBar(
        // iconSize: 32.0,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(title:  Text("readhub"), icon:  Icon(Icons.message)),
          BottomNavigationBarItem(title:  Text("必应图片"), icon:  Icon(Icons.home)),
          BottomNavigationBarItem(title:  Text("每日一句"), icon:  Icon(Icons.list)),
        ],
        //设置显示的模式
        type: BottomNavigationBarType.fixed,
        //设置当前的索引
        currentIndex: _tabIndex,
        //tabBottom的点击监听
        onTap: (index) {
          setState(() {
            _tabIndex = index;
          });
        },
      ),
    );
  }
}
