import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

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
                  Row(children: [
                    IconButton(
                        iconSize: 30,
                        alignment: Alignment.topLeft,
                        icon: Icon(Icons.arrow_back_rounded),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.75,
                        alignment: Alignment.center,
                        child: Text(
                          'POSTAGENS',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )),
                  ]),
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
                          DataColumn(
                            label: Text(
                              'Id do \nUsuário',
                              textAlign: TextAlign.center,
                            ),
                            numeric: false,
                          ),
                          DataColumn(
                            label: Text(
                              'Id',
                            ),
                            numeric: true,
                          ),
                          DataColumn(
                            label: Text(
                              'Título',
                            ),
                            numeric: false,
                          ),
                        ],
                        rows: data
                            .map(
                              (post) => DataRow(
                                cells: [
                                  DataCell(
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        post.userId.toString(),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        post.id.toString(),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        post.title.toString(),
                                      ),
                                    ),
                                  ),
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
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
                SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}
