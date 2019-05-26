import 'package:flutter/material.dart';

///支持顶部和顶部的TabBar控件
///配合AutomaticKeepAliveClientMixin可以keep住
class TabBarWidget extends StatefulWidget {
  final double elevation;

  final List<Widget> tabItems;

  final List<Widget> tabViews;

  final Color backgroundColor;

  final Color indicatorColor;

  final Widget title;

  final Widget drawer;

  final Widget floatingActionButton;

  final TarWidgetControl tarWidgetControl;

  final PageController topPageControl;

  final ValueChanged<int> onPageChanged;

  final bool isScrollable;

  TabBarWidget({
    Key key,
    this.tabItems,
    this.tabViews,
    this.backgroundColor,
    this.indicatorColor,
    this.title,
    this.drawer,
    this.floatingActionButton,
    this.tarWidgetControl,
    this.topPageControl,
    this.onPageChanged,
    this.elevation = 4.0,
    this.isScrollable = false,
  }) : super(key: key);

  @override
  _TabBarWidgetState createState() => new _TabBarWidgetState(
        tabViews,
        // indicatorColor,
        title,
        drawer,
        floatingActionButton,
        tarWidgetControl,
        // topPageControl,
        // onPageChanged,
        elevation,
        isScrollable,
      );
}

// ignore: mixin_inherits_from_not_object
class _TabBarWidgetState extends State<TabBarWidget> with SingleTickerProviderStateMixin {

  final double _elevation;

  final List<Widget> _tabViews;

  // final Color _indicatorColor;

  final Widget _title;

  final Widget _drawer;

  final Widget _floatingActionButton;

  final TarWidgetControl _tarWidgetControl;

  // final PageController _pageController;

  // final ValueChanged<int> _onPageChanged;

  final bool _isScrollable;

  _TabBarWidgetState(
      this._tabViews,
      // this._indicatorColor,
      this._title,
      this._drawer,
      this._floatingActionButton,
      this._tarWidgetControl,
      // this._pageController,
      // this._onPageChanged,
      this._elevation,
      this._isScrollable)
      : super();

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        new TabController(vsync: this, length: widget.tabItems.length);
  }

  ///整个页面dispose时，记得把控制器也dispose掉，释放内存
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
      ///顶部tab bar
      return new Scaffold(
        drawer: _drawer,
        floatingActionButton: _floatingActionButton,
        persistentFooterButtons:
            _tarWidgetControl == null ? null : _tarWidgetControl.footerButton,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: new AppBar(
            elevation: _elevation,
            backgroundColor: Theme.of(context).primaryColor,
            title: _title,
            bottom: new TabBar(
              controller: _tabController,
              tabs: widget.tabItems,
              // indicatorColor: _indicatorColor,
              indicatorSize: TabBarIndicatorSize.label,
              // labelColor: Colors.white,
              isScrollable: _isScrollable,
              labelStyle: new TextStyle(fontSize: 16.0),
              unselectedLabelColor: Colors.grey,
              unselectedLabelStyle: new TextStyle(fontSize: 16.0),
            ),
          )
        ),
        body: TabBarView(
          controller: _tabController,
          children: _tabViews,
        ),
      );
  }
}

class TarWidgetControl {
  List<Widget> footerButton = [];
}
