import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';
import '../util/api_utils.dart';
import '../model/bin_picture_model.dart';
import 'package:extended_image/extended_image.dart';

// bin搜索图片
class BingPicture extends StatefulWidget {
  const BingPicture() :super();
  
  @override
  _BingPictureState createState() => _BingPictureState();
}

class _BingPictureState extends State<BingPicture> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  List items = new List();
  
  Future<List> _getPicturesData([Map<String, dynamic> params]) async {
    // URL地址
    const bin_url = 'https://cn.bing.com/HPImageArchive.aspx';
    // 参数
    final _param = {'idx': 0, 'n': 8, 'format': 'js', 'mkt': 'zh-CN'};
    // 返回结果
    var response = await ApiUtils.get(bin_url, params: _param);
    var responseImages = response['images'];
    List resultList = new List();
    for (int i = 0; i < responseImages.length; i++) {
      try {
      // json数据转化model
        BinPictureModel cellData = new BinPictureModel.fromJson(responseImages[i]);
        resultList.add(cellData);
      } catch (e) {
        // No specified type, handles all
      }
    }
  // 刷新页面
    setState(() {
      items.addAll(resultList);
    });
   
    return resultList;
  }
   
  @override
  initState() { 
    super.initState();   
    _getPicturesData();
  }
  
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return new ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return new StickyHeader(
          header: new Container(
            height: 50.0,
            color: Colors.blueGrey[700],
            padding: new EdgeInsets.symmetric(horizontal: 16.0),
            alignment: Alignment.centerLeft,
            child: new Text(items[index].copyright,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          content: new Container(
            child: ExtendedImage.network(
                items[index].url,
                fit: BoxFit.cover,
                //enableLoadState: false,
                mode: ExtendedImageMode.Gesture,
                gestureConfig: GestureConfig(
                    minScale: 0.9,
                    animationMinScale: 0.7,
                    maxScale: 3.0,
                    animationMaxScale: 3.5,
                    speed: 1.0,
                    inertialSpeed: 100.0,
                    initialScale: 1.0,
                    inPageView: false),
              ),
            // child: new Image.network(items[index].url, fit: BoxFit.cover,
            //   width: double.infinity),
          ),
        );
    });
  }
}