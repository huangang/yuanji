import 'package:flutter/material.dart';
import './ui/main/FirstPage.dart';
import './ui/main/SecondPage.dart';
import './ui/main/ThirdPage.dart';

class ReadHubApp extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    return new ReadHubAppState();
  }
}

class ReadHubAppState extends State<ReadHubApp>
    with SingleTickerProviderStateMixin {

  TabController controller;
  List<Tab> titleList = [
    new Tab(child: new Text("热门话题")),
    new Tab(child: new Text("科技动态")),
    new Tab(child: new Text("开发者资讯"))
  ];
  List<Widget>tabViewList = [
    new FirstPage(),
    new SecondPage(),
    new ThirdPage()
  ];

  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: new AppBar(
          bottom: new TabBar(
            tabs: titleList,
            controller: controller,
          ))
        ), 
      body: new TabBarView(
        children: tabViewList,
        controller: controller,
      ),
    );
  }
}