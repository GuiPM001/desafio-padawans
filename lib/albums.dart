import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Albums {
  int userId;
  int id;
  String title;

  Albums({this.userId, this.id, this.title});

  factory Albums.fromJson(Map<String, dynamic> json) {
    return Albums(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}

Future<List<Albums>> fetchAlbums() async {
  final response =
      await http.get('https://jsonplaceholder.typicode.com/albums');

  if (response.statusCode == 200) {
    var parsed = json.decode(response.body);

    List jsonReponse = parsed as List;

    return jsonReponse.map((list) => new Albums.fromJson(list)).toList();
  } else {
    print('Error, could not load data.');
  }
}

class AlbumsTable extends StatefulWidget {
  @override
  _AlbumsTableState createState() => _AlbumsTableState();
}

class _AlbumsTableState extends State<AlbumsTable> {
  Future<List<Albums>> _func;

  @override
  void initState() {
    _func = fetchAlbums();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Albums>>(
        future: _func,
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            List<Albums> data = snapshot.data;
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
                          'ÁLBUNS',
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
                            color: Colors.blue[600],
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                        columns: [
                          DataColumn(
                            label: Text(
                              'Id do \nUsuário',
                              textAlign: TextAlign.center,
                            ),
                            numeric: true,
                          ),
                          DataColumn(
                            label: Text('Id'),
                            numeric: true,
                          ),
                          DataColumn(
                            label: Text('Título'),
                            numeric: false,
                          ),
                        ],
                        rows: data
                            .map(
                              (album) => DataRow(
                                cells: [
                                  DataCell(
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        album.userId.toString(),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        album.id.toString(),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        album.title.toString(),
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
              ],
            ),
          );
        },
      ),
    );
  }
}
