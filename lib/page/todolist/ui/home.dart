import 'package:flutter/material.dart';
import './todo_screen.dart';

class TodoListtHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Todo List'),
        centerTitle: true,
        // backgroundColor: Colors.black54,
      ),
      body: new TodoScreen(),
    );
  }
}