import 'package:flutter/material.dart';
import '../util/api_utils.dart';
import 'dart:convert';


class RandImage extends StatefulWidget {
  @override
  _RandImageState createState() => _RandImageState();
}

class _RandImageState extends State<RandImage> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;
  String imageUrl = 'https://api.uomg.com/api/rand.img2';

  Future _getRandImage() async{
    final response = await ApiUtils.get('https://api.uomg.com/api/rand.img2?format=json');
    final data = json.decode(response);
    setState(() {
      imageUrl = data['imgurl'];
    });
  }

  @override
  initState() { 
    super.initState();
    _getRandImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation:  FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _getRandImage();
        },
        child: Icon(Icons.cached),
        elevation: 0.0,
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      ),
      body: Center(
        child: new Image.network(
          imageUrl,
          fit: BoxFit.cover,
          height: MediaQuery.of(context).size.height
        ),
      )
    );
  }
}