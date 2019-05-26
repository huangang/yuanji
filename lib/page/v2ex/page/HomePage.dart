import 'package:flutter/material.dart';
import 'package:yuanji/page/v2ex/entity/LocalNode.dart';
import 'package:yuanji/page/v2ex/widget/TabBarWidget.dart';

import 'HomeTabPage.dart';

class V2exHomePage extends StatelessWidget {
  
  final tabNodes = [
    LocalNode("最新"),
    LocalNode("热议"),
    LocalNode("技术", path: "tech"),
    LocalNode("创意", path: "creative"),
    LocalNode("好玩", path: "play"),
    LocalNode("Apple", path: "apple"),
    LocalNode("酷工作", path: "jobs"),
    LocalNode("交易", path: "deals"),
    LocalNode("城市", path: "city"),
    LocalNode("问与答", path: "qna"),
    LocalNode("最热", path: "hot"),
    LocalNode("全部", path: "all"),
    LocalNode("R2", path: "r2"),
//    LocalNode("关注", path: "members"),
  ];

  _renderTabs() {
    List<Widget> tabs = List();
    for (LocalNode node in tabNodes) {
      tabs.add(Tab(
        child: Text(node.node),
      ));
    }
    return tabs;
  }

  _renderTabViews() {
    List<Widget> tabViews = List();
    for (LocalNode node in tabNodes) {
      tabViews.add(HomeTabPage(node));
    }
    return tabViews;
  }

  @override
  Widget build(BuildContext context) {
    return TabBarWidget(
        elevation: 0.0,
        // indicatorColor: Colors.white10,
        tabItems: _renderTabs(),
        tabViews: _renderTabViews(),
        isScrollable: true,
    );
  }
}
