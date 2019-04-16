import 'package:flutter/material.dart';
import './util/api_utils.dart';
import './model/bin_picture_model.dart';

// bin搜索图片
class BinPicture extends StatefulWidget {
  const BinPicture() :super();
  
  @override
  _BinPictureState createState() => _BinPictureState();
}

class _BinPictureState extends State<BinPicture> {
  bool isLoading = false; // 是否正在请求数据中,
  int _pageIndex = 0; // 页面的索引
  bool _hasMore = true;
  List items = new List();
  ScrollController _scrollController = new ScrollController();
  
  Future<Map> _getPicturesData([Map<String, dynamic> params]) async {
    // URL地址
    const bin_url = 'https://cn.bing.com/HPImageArchive.aspx';
    var pageIndex = (params is Map) ? params['pageIndex'] : 0;
    // 参数
    final _param = {'idx': pageIndex, 'n': 10, 'format': 'js', 'mkt': 'zh-CN'};
    // 返回结果
    var response = await ApiUtils.get(bin_url, params: _param);
    var responseImages = response['images'];
    var pageTotal = responseImages.length;
    if (!(pageTotal is int) || pageTotal <= 0) {
      pageTotal = 0;
    }
    pageIndex = pageIndex + pageTotal;
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
// 自定义数据
    Map<String, dynamic> result = {
      "list": resultList,
      'total': pageTotal,
      'pageIndex': pageIndex,
    };
    return result;
  }
   
  @override
  initState() { 
    super.initState();   
    _getMoreData();
    _scrollController.addListener(() {
      // 如果下拉的当前位置到scroll的最下面
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }
  
  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  Future _getMoreData() async {
    // 如果加载数据loading为true,同时还有更多数据需要加载
    if (!isLoading && _hasMore) {
      setState(() {
        isLoading = true;
      });
      List newEntries = await mokeHttpRequest();
      // 状态加载完成执行
      if (this.mounted) {
        setState(() {
          items.addAll(newEntries);
          isLoading = false;
        });
      }
    }
  }
  // 数据请求
  Future<List> mokeHttpRequest() async {
    // 传入索引值
    final listObj = await _getPicturesData({'pageIndex': _pageIndex});
    _pageIndex = listObj['pageIndex'];
    print(_pageIndex);
    _hasMore = false;
    return listObj['list'];
  }

  Widget _buildProgressIndicator() {
    if (_hasMore) {
      return new Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Center(
            child: Column(
              children: <Widget>[
                new Opacity(
                  opacity: isLoading ? 1.0 : 0.0,
                  child: new CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.green)),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    '数据加载中...',
                    style: TextStyle(fontSize: 14.0),
                  )
                ],
              )
              //child:
            ),
        );
    } else {
      return _buildLoadText();
    }
  }

  Widget _buildLoadText() {
    return Container(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Center(
            child: Text("没有数据更多了！！！"),
          ),
    ));
  }

  Future<Null> _handleRefresh() async {
    List newEntries = await mokeHttpRequest();
    // this.mounted标识完成请求后更新数据
    if (this.mounted) {
      setState(() {
        items.clear();
        items.addAll(newEntries);
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return new RefreshIndicator(
      child: ListView.builder(
        itemCount: items.length + 1,
        itemBuilder: (context, index) {
          if (index == items.length) {
            return _buildProgressIndicator();
          } else {

              return Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Image.network(items[index].url),
                  ),
                  Text(items[index].copyright),
                ],
              );
          
          }
        },
        // 用于监控列表滑到底部
        controller: _scrollController,
      ),
      // 刷新函数
      onRefresh: _handleRefresh,
      color: Colors.green,
    );
  }
}