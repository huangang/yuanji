import 'package:flutter/material.dart';
import '../ui/todo_item.dart';
import '../util/database_client.dart';
import '../util/date_formatter.dart';

class TodoScreen extends StatefulWidget {

  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {

  final TextEditingController _textEditingController = new TextEditingController();
  var db = new DatabaseHelper();
  final List<TodoItem> _itemList = <TodoItem>[];

  @override
  void initState() {
    super.initState();
    _readTodoList();

  }

  void _handleSubmitted(String text) async {

    _textEditingController.clear();
    TodoItem toDoItem = new TodoItem(text, dateFormatted());
    int savedItemId = await db.saveItem(toDoItem);
    print("Item saved id: $savedItemId");

    TodoItem addedItem = await db.getItem(savedItemId);

    setState(() {
      _itemList.insert(0, addedItem);
    });

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // backgroundColor: Colors.black87,
      body: Column(
        children: <Widget>[
          new Flexible(
            child: new ListView.builder(
              itemCount: _itemList.length,
              padding: new EdgeInsets.all(8.0),
              reverse: false,
              itemBuilder: (_, int index){
                return new Card(
                  color: Color.fromRGBO(64, 75, 96, .9),
                  child: new ListTile(
                    title: _itemList[index],
                    onLongPress: () => _updateItem(_itemList[index], index),
                    trailing: new Listener(
                      key: new Key(_itemList[index].itemName),
                      child: new Icon(Icons.remove_circle,
                      color: Colors.redAccent,),
                      onPointerDown: (pointerEvent) => 
                          _deleteTodo(_itemList[index].id, index),
                    ),
                  ),
                );
              }))
        ],
      ),

      floatingActionButton: new FloatingActionButton(
        tooltip: "Add item",
        backgroundColor: Colors.redAccent,
        child: new ListTile(
          title: new Icon(Icons.add),
        ),
        onPressed: _showFormDialog,
        
              ),
            );
          }
        
  void _showFormDialog() {

    var alert = new AlertDialog(
      content: new Row(
        children: <Widget>[
          new Expanded(
            child: new TextField(
              controller: _textEditingController,
              autofocus: true,
              decoration: new InputDecoration(
                labelText: "任务",
                hintText: "例. 跑步30分钟",
                icon: new Icon(Icons.note_add)
              ),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            _handleSubmitted(_textEditingController.text);
            _textEditingController.clear();
            Navigator.pop(context);
          },
          child: new Text("保存")),
        new FlatButton(onPressed: () => Navigator.pop(context),
        child: new Text("取消",
        style: new TextStyle(color: Colors.redAccent),
        ))
      ],
    );
    showDialog(context: context,
        builder: (_) {

          return alert;

        });
    


  }

    void _readTodoList() async {

    List items = await db.getItems();
    items.forEach((item) {
      // TodoItem toDoItem = TodoItem.map(item);
      setState(() {

        _itemList.add(TodoItem.map(item));
          
      });
      // print("Db items: ${toDoItem.itemName}");

    });

  }

  void _deleteTodo(int id, int index) async {

    debugPrint("Deleted Item!");
    await db.deleteItem(id);
    setState(() {
      _itemList.removeAt(index);
          
    });
  }

  void _updateItem(TodoItem item, int index) async {

    var alert = new AlertDialog(
      title: new Text("更新任务"),
      content: Row(
        children: <Widget>[
          new Expanded(
            child: new TextField(
              controller: _textEditingController,
              autofocus: true,

              decoration: new InputDecoration(
                labelText: "任务",
                hintText: "例. 一些事情",
                icon: new Icon(Icons.update)
              ),
            ),
          )
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () async {

            TodoItem newItemUpdated = TodoItem.fromMap({
                "itemName": _textEditingController.text,
                "dateCreated": dateFormatted(),
                "id": item.id
              });

              _handleSubmittedUpdate(index, item); //Redrawing screen
              await db.updateItem(newItemUpdated); //Updating the task
              setState(() {

                _readTodoList(); //Redrawing the screen with all items saved in the db
                              
              });
              _textEditingController.clear();
              Navigator.pop(context);

          },
          child: new Text("更新"),
        ),
        new FlatButton(onPressed: () => Navigator.pop(context),
            child: new Text("取消",
            style: new TextStyle(color: Colors.redAccent),
            ),
        )
      ],
    );
    showDialog(context: context, builder: (_) {

      return alert;

    });

  }

  void _handleSubmittedUpdate(int index, TodoItem item) async {

    setState(() {
      _itemList.removeWhere((element) => _itemList[index].itemName == item.itemName);
    });

  }

}