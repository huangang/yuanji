import 'package:flutter/material.dart';
import '../util/date_formatter.dart';

class Item {
  String name;
  int id;
  int modified;

  Item ({
    this.name,
    this.id,
    this.modified
  });

  Item.map(dynamic obj){
    this.name = obj["name"];
    this.id = obj["id"];
    this.modified = obj["modified"];
  }

   Map<String, dynamic> toMap(){
    var map = new Map<String, dynamic>();
    map["name"] = this.name;

    if (this.id != null){
      map["id"] = this.id;
    }
    map['modified'] = DateTime.now().millisecondsSinceEpoch;
    return map;
  }

  Item.fromMap(Map<String, dynamic> map){
    this.name = map["name"];
    this.id = map["id"];
    this.modified = map["modified"];
  }
}

class TodoItem extends StatelessWidget {

  final Item item;

  TodoItem(this.item);

  String get name => this.item.name;
  int get id => this.item.id;

  @override
  Widget build(BuildContext context) {
    var modified = dateFormatted(this.item.modified);
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              new Text(this.item.name,
                style: new TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 17.0,
              ),),

              new Container(
                margin: const EdgeInsets.only(top:5.0),
                child: Text("创建于: $modified",
                style: new TextStyle(
                  color: Colors.white70,
                  fontSize: 13.5,
                  fontStyle: FontStyle.italic
                ),),
              )

            ],
          ),
        ],
      ), 
    );
  }
}