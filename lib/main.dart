import 'package:flutter/material.dart';
import 'albums.dart';
import 'posts.dart';
import 'todos.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("T A B E L A S",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500)),
            FlatButton(
              color: Colors.red[600],
              textColor: Colors.white,
              height: 100,
              minWidth: 140,
              child: Text(
                "POSTAGENS",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return PostsTable();
                  }),
                );
              },
            ),
            FlatButton(
              color: Colors.blue[600],
              textColor: Colors.white,
              height: 100,
              minWidth: 140,
              child: Text(
                "ÁLBUNS",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return AlbumsTable();
                  }),
                );
              },
            ),
            FlatButton(
              color: Colors.green[600],
              textColor: Colors.white,
              height: 100,
              minWidth: 140,
              child: Text(
                "TO-DOs",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return ToDosTable();
                  }),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
