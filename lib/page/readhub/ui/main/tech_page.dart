
import 'dart:async';
import 'package:flutter/material.dart';
import '../news_item_view.dart';
import '../../../../util/api_utils.dart';
import '../../model/news_model.dart';

class TechPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new TechPageState();
  }
}

class TechPageState extends State<TechPage> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  bool isLoading = false; // 是否正在请求数据中,
  int _pageIndex = DateTime.now().millisecondsSinceEpoch; // 页面的索引

  bool _hasMore = true;
  List items = new List();
  ScrollController _scrollController = new ScrollController();

  Future<Map> _getTopicData([Map<String, dynamic> params]) async {
    print(_pageIndex);
    // URL地址
    const api_url = 'https://api.readhub.cn/technews';
    var pageIndex = (params is Map) ? params['pageIndex'] : 0;
    // 参数
    final _param = {'lastCursor': pageIndex, 'pageSize': 20};
    // 返回结果
    var response = await ApiUtils.get(api_url, params: _param);
    var responseData = response['data'];
    print(responseData);
    var pageTotal = responseData.length;

    if (!(pageTotal is int) || pageTotal <= 0) {
      pageTotal = 0;
    }
    
    List resultList = new List();
    for (int i = 0; i < responseData.length; i++) {
      try {
        // json数据转化model
        print(responseData[i]);
        NewsModel cellData = new NewsModel.fromJson(responseData[i]);
        pageIndex = DateTime.parse(cellData.publishDate).millisecondsSinceEpoch;
        print(pageIndex);
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
      'list': resultList,
      'total': pageTotal,
      'pageIndex': pageIndex,
      'totalItems': response['totalItems'],
      'totalPages': response['totalPages'],
    };
    return result;
  }

  @override
  void initState() {
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
    final listObj = await _getTopicData({'pageIndex': _pageIndex});
    _pageIndex = listObj['pageIndex'];
    _hasMore = items.length < listObj['totalItems'];
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
        itemCount: items.length,
        itemBuilder: (context, index) {
          print(items[index]);
          if (index == items.length) {
            return _buildProgressIndicator();
          } else {
              return new NewsItemView(items[index].title, items[index].publishDate, items[index].mobileUrl);
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
