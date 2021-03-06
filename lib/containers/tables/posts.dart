import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../components/header.dart';
import '../../components/loading.dart';
import '../../components/tableComponent.dart';

class Posts {
  int userId;
  int id;
  String title;

  Posts({this.userId, this.id, this.title});

  factory Posts.fromJson(Map<String, dynamic> json) {
    return Posts(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}

// ignore: missing_return
Future<List<Posts>> fetchAlbums() async {
  final response = await http.get('https://jsonplaceholder.typicode.com/posts');

  if (response.statusCode == 200) {
    var parsed = json.decode(response.body);
    List jsonReponse = parsed as List;
    return jsonReponse.map((list) => new Posts.fromJson(list)).toList();
  } else {
    print('Error, could not load data.');
  }
}

class PostsTable extends StatefulWidget {
  @override
  _PostsTableState createState() => _PostsTableState();
}

class _PostsTableState extends State<PostsTable> {
  Future<List<Posts>> _func;

  @override
  void initState() {
    _func = fetchAlbums();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Posts>>(
        future: _func,
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            List<Posts> data = snapshot.data;
            return SingleChildScrollView(
              padding: EdgeInsets.only(top: 35),
              child: Column(
                children: [
                  Header(titleTable: "Posts"),
                  Container(
                    child: SingleChildScrollView(
                      child: DataTable(
                        columnSpacing: 25,
                        dataRowHeight: 55,
                        headingTextStyle: TextStyle(
                            color: Colors.red[600],
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                        columns: [
                          TableComponent.column('Id', true),
                          TableComponent.column('User-id', true),
                          TableComponent.column('Title', false)
                        ],
                        rows: data
                            .map(
                              (post) => DataRow(
                                cells: [
                                  TableComponent.cell(post.id.toString()),
                                  TableComponent.cell(post.userId.toString()),
                                  TableComponent.cell(post.title.toString())
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return Loading.loadingScreen();
        },
      ),
    );
  }
}
