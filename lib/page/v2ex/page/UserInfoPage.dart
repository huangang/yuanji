import 'dart:ui';

import 'package:extended_image/extended_image.dart';

import 'package:flutter/material.dart';
import 'package:yuanji/page/v2ex/entity/Member.dart';
import 'package:yuanji/page/v2ex/entity/UserInfo.dart';
import 'package:yuanji/page/v2ex/net/V2EXManager.dart';
import 'package:yuanji/page/v2ex/utils/HtmlParseUtil.dart';
import 'package:yuanji/page/v2ex/utils/UrlHelper.dart';
import 'package:yuanji/page/v2ex/widget/UserInfoItemWidget.dart';

class UserInfoPage extends StatefulWidget {
  final Member member;

  UserInfoPage(this.member);

  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

enum AppBarBehavior { normal, pinned, floating, snapping }

class _UserInfoPageState extends State<UserInfoPage> {
  UserInfo userInfo;
  final double _appBarHeight = 256.0;

  ///顶部tabbar
  _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: _appBarHeight,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Container(
//          color: Colors.red,
          child: Text(userInfo.member.username),
        ),
        centerTitle: false,
        background: _buildUserInfo(),
      ),
    );
  }

  _buildUserInfo() {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(
          height: _appBarHeight,
//          color: Colors.green,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 1.0),
            child: Opacity(
              opacity: 0.5,
              child: ExtendedImage.network(
                UrlHelper.getImageUrl(userInfo.member.avatarNormal),
                fit: BoxFit.fill,
                cache: true,
              )
              // child: CachedNetworkImage(
              //     fit: BoxFit.fill,
              //     imageUrl:
              //         UrlHelper.getImageUrl(userInfo.member.avatarNormal)),
            ),
          ),
        ),
        // This gradient ensures that the toolbar icons are distinct
        // against the background image.
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.0, -1.0),
              end: Alignment(0.0, -0.4),
              colors: <Color>[Color(0x60000000), Color(0x00000000)],
            ),
          ),
        ),
      ],
    );
  }

  _buildSliverList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              UserInfoItemWidget(userInfo.topics[index], widget.member),
              Divider(height: 1.0),
            ],
          );
        },
        childCount: userInfo.topics.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _buildSliverAppBar(),
          _buildSliverList(),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    ///初始化用户信息
    userInfo = UserInfo();
    userInfo.topics = List();
    userInfo.member = widget.member;
    getData();
  }

  void getData() {
    V2EXManager.getUserInfo(
      widget.member.username,
      (data) {
        var htmlParseUtil = HtmlParseUtil();
        //解析用户信息也
        UserInfo tempUserInfo =
            htmlParseUtil.parseUserInfo(data, userInfo: userInfo);
        print(widget.member.avatarNormal);
        setState(() {
          userInfo = tempUserInfo;
        });
      },
    );
  }
}
