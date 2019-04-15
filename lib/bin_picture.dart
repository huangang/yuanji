import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

// bin搜索图片


class BinPicture extends StatefulWidget {
  @override
  _BinPictureState createState() => _BinPictureState();
}

class _BinPictureState extends State<BinPicture> {


  List pictures = [];
  Future getPicture() async {
    try {
      Response response = await Dio().get("https://cn.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1&mkt=zh-CN", 
      options: Options(responseType: ResponseType.json));
      print(response);

      return response.data['images'];
    } catch (e) {
      print(e);
    }
    return null;
  }
   
  // @override
  // initState() { 
  //   super.initState();   
    // getPicture().then((images) {
    //   setState(() {
    //     pictures = images;
    //   });
    // });
  // }
  
  @override
  Widget build(BuildContext context) {
    // super.build(context);
    // if (pictures.length <= 0) {
    //   return new Container(child: Text('loading'));
    // }else {
      return new Container(
        child: new OverflowBox(
        minWidth: 0.0, 
        minHeight: 0.0, 

        maxWidth: double.infinity, 
        child: new Image.network('https://cn.bing.com/th?id=OHR.AlpineEucalyptBark_ZH-CN2046783535_1920x1080.jpg&rf=LaDigue_1920x1080.jpg&pid=hp',
        fit: BoxFit.cover)
      ) 
    ); 
    // } 
  }
}