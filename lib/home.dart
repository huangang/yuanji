import 'package:flutter/material.dart';
import './bin_picture.dart';

class HomePageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new HomePageState();
  }
}

class HomePageState extends State<HomePageWidget> {
  int _tabIndex = 0;
  /*
   * 存储的四个页面，和Fragment一样
   */
  var _bodys;

  void initData() {
    _bodys = [
      new BinPicture(),
      new BinPicture(),
      new BinPicture(),
      new BinPicture(),
      new BinPicture()
    ];
  }

  @override
  Widget build(BuildContext context) {
    initData();
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        title: new Text("主页"),
      ),
      body: _bodys[_tabIndex],
      bottomNavigationBar: new BottomNavigationBar(
        // iconSize: 32.0,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(title: Text("Home"), icon:  Icon(Icons.home)),
          BottomNavigationBarItem(title:  Text("List"), icon:  Icon(Icons.list)),
          BottomNavigationBarItem(title:  Text("Message"), icon:  Icon(Icons.message)),
          BottomNavigationBarItem(title:  Text("Add"), icon:  Icon(Icons.add)),
          BottomNavigationBarItem(title:  Text("Other"), icon:  Icon(Icons.devices_other)),
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
