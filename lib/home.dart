import 'package:flutter/material.dart';
import './page/bing_picture.dart';
import './page/readhub/app.dart';
import './page/more.dart';
import './page/weather.dart';

class HomePageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePageWidget> {
  int currentIndex = 0;

  final pageController = PageController();

  void onTap(int index) {
    pageController.jumpToPage(index);
  }

  final items = [
    BottomNavigationBarItem(title:  Text("readhub"), icon:  Icon(Icons.view_list)),
    BottomNavigationBarItem(title:  Text("必应图片"), icon:  Icon(Icons.picture_in_picture)),
    BottomNavigationBarItem(title:  Text("天气预报"), icon:  Icon(Icons.cloud_done)),
    BottomNavigationBarItem(title:  Text("更多应用"), icon:  Icon(Icons.more)),
  ];

  final titles = [
    new Text("readhub"),
    new Text("必应图片"),
    new Text("天气预报"),
    new Text("更多应用"),
  ];

  final bodyList = [ReadHubApp(), BingPicture(), WeatherApp(), More()];

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: new AppBar(
        title: titles[currentIndex],
        centerTitle: true,
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: bodyList,
      ),
      bottomNavigationBar: new BottomNavigationBar(
        // iconSize: 32.0,
        items: items,
        //设置显示的模式
        type: BottomNavigationBarType.fixed,
        //设置当前的索引
        currentIndex: currentIndex,
        //tabBottom的点击监听
        onTap: (index) {
          pageController.jumpToPage(index);
        },
      ),
    );
  }
}
