import 'package:flutter/material.dart';
import 'package:yuanji/page/v2ex/entity/Topic.dart';
import 'package:yuanji/page/v2ex/utils/NavigatorUtils.dart';
import 'package:yuanji/page/v2ex/utils/UrlHelper.dart';
import 'package:yuanji/page/v2ex/utils/timeline_util.dart';
import 'package:yuanji/page/v2ex/widget/AvatarWidget.dart';
import 'package:yuanji/page/v2ex/widget/NodeTagWidget.dart';

class TopicItemWidget extends StatefulWidget {
  final Topic mTopic;

  final VoidCallback onItemClick;

  TopicItemWidget(this.mTopic, {this.onItemClick});

  @override
  _TopicItemWidgetState createState() => _TopicItemWidgetState();
}

class _TopicItemWidgetState extends State<TopicItemWidget> {
  _buildItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AvatarWidget(
              UrlHelper.getImageUrl(widget.mTopic.member.avatarNormal),
              onPress: () {
                NavigatorUtils.toUserInfo(context, widget.mTopic.member);
              },
            ),
            _buildNameAndTime(),
            NodeTagWidget(widget.mTopic.node.name, widget.mTopic.node.title),
          ],
        ),
        Padding(padding: EdgeInsets.only(top: 8.0)),
        _buildContent(),
      ],
    );
  }

  ///名称和时间
  _buildNameAndTime() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(left: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.mTopic.member.username,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black87,
              ),
            ),
            Text(
              _getReplyTimeNum(),
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///节点标签
  _buildNodeTag() {
    return RawMaterialButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        constraints: const BoxConstraints(minWidth: 0.0, minHeight: 0.0),
        child: Container(
          padding: EdgeInsets.fromLTRB(10.0, 6.0, 10.0, 6.0),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(2.0),
          ),
          child: Text(
            widget.mTopic.node.title,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
        ),
        onPressed: () {
          NavigatorUtils.toNodeInfo(
              context, widget.mTopic.node.name, widget.mTopic.node.title);
        });
  }

  _buildContent() {
    return Text(
      widget.mTopic.title,
      style: TextStyle(
        fontSize: 16.0,
        color: Colors.black,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.all(11.0),
      color: Colors.white,
      onPressed: _onPressed(),
      child: _buildItem(),
    );
  }

  String _getReplyTimeNum() {
    String timeNum = "";
    String time = widget.mTopic.replyTime == null
        ? TimelineUtil.format(widget.mTopic.lastModified * 1000,
            dayFormat: DayFormat.Full)
        : widget.mTopic.replyTime;
    int num = widget.mTopic.replies;
    timeNum = time == "" ? "" : time + (num == 0 ? "" : " 评论" + num.toString());
    return timeNum;
  }

  _onPressed() {
    if (widget.onItemClick == null) {
      return () {
        NavigatorUtils.toTopicDetail(context, widget.mTopic.id);
      };
    } else {
      return widget.onItemClick;
    }
  }
}
