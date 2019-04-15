import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

// bin搜索图片

class BinPicture extends StatelessWidget {


 Future getPicture() async {
    try {
      Response response = await Dio().get("https://cn.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1&mkt=zh-CN", 
      options: Options(responseType: ResponseType.json));
      // print(response);
      return response.data['images'];
    } catch (e) {
      print(e);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    List pictures;
    getPicture().then((images) {
      pictures = images;
      print(pictures);
    });
    return new Image.network('https://bing.com/th?id=OHR.YukonEmerald_ZH-CN1893750172_1920x1080.jpg&rf=LaDigue_1920x1080.jpg&pid=hp',
    fit: BoxFit.cover
    );
  }
}