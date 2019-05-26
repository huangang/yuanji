import 'package:flutter/material.dart';
import 'package:yuanji/page/v2ex/entity/Member.dart';
import 'package:yuanji/page/v2ex/page/LoginPage.dart';
import 'package:yuanji/page/v2ex/page/NodeCategoryPage.dart';
import 'package:yuanji/page/v2ex/page/NodeInfoPage.dart';
import 'package:yuanji/page/v2ex/page/TopicDetailPage.dart';
import 'package:yuanji/page/v2ex/page/UserInfoPage.dart';

class NavigatorUtils {
  ///个人中心
  static toUserInfo(BuildContext context, Member member) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => UserInfoPage(member)));
  }

  ///节点页
  static toNodeInfo(BuildContext context, String nodeName, String nodeTitle) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => NodeInfoPage(nodeName, nodeTitle)));
  }

  ///topic
  static toTopicDetail(BuildContext context, int topicId) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => TopicDetailPage(topicId)));
  }

  ///节点分类
  static toNodeCategory(BuildContext context) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => NodeCategoryPage()));
  }

  ///登录页
  static toLogin(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => LoginPage()));
  }
}
