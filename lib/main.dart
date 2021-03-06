import 'package:flutter/material.dart';
import 'package:teste_framework/components/button.dart';

import 'components/button.dart';
import './containers/tables/albums.dart';
import './containers/tables/posts.dart';
import './containers/tables/todos.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Access to Tables",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500)),
            NavTableButton.button(
                Colors.red[600], "Posts", context, PostsTable()),
            NavTableButton.button(
                Colors.blue[600], "Albums", context, AlbumsTable()),
            NavTableButton.button(
                Colors.green[600], "To-dos", context, ToDosTable()),
          ],
        ),
      ),
    );
  }
}
