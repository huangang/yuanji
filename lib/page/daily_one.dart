import 'package:flutter/material.dart';
import '../util/api_utils.dart';
import 'dart:convert';
import 'package:audioplayer/audioplayer.dart';
import 'dart:ui';

class DailyOne extends StatefulWidget {
  @override
  _DailyOneState createState() => _DailyOneState();
}

class _DailyOneState extends State<DailyOne> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  
  AudioPlayer audioPlayer = new AudioPlayer();

  Future <Object> _getDailyData() async{
    final response = await ApiUtils.get('http://open.iciba.com/dsapi/');
    return json.decode(response);
  }

  Future playAudio(kUrl) async {
    await audioPlayer.play(kUrl);
  }

  @override
  initState() { 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: new AppBar(
        title: new Text('每日一句'),
        centerTitle: true,
      ),
      body: FutureBuilder(
      future: _getDailyData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.active:
          case ConnectionState.waiting:
           return Text('请求中');
          case ConnectionState.done:
               return new Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Center(
                    child: Column(
                      children: <Widget>[
                        Image.network(snapshot.data['picture2']),
                        FlatButton(
                          child: Text(snapshot.data['content'], style: TextStyle(fontSize: 24, color: Colors.blue[400])),
                          onPressed: () {
                            playAudio(snapshot.data['tts']);
                          },
                        ),
                        Text(snapshot.data['note'],style: TextStyle(fontSize: 24),),
                        Text(snapshot.data['dateline'], style: TextStyle(fontSize: 24),),
                      ]
                    )
                )
              );
        }
        return null;
      },
    ),
    ); 
  }
}