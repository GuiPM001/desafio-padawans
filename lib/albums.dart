import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'components/header.dart';
import 'components/loading.dart';
import 'components/tableComponents.dart';

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
                  Header(titleTable: "ÁLBUNS"),
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
                          TableComponents.column('Id do \nUsuário', true),
                          TableComponents.column('Id', true),
                          TableComponents.column('Título', false)
                        ],
                        rows: data
                            .map(
                              (album) => DataRow(
                                cells: [
                                  TableComponents.cell(album.userId.toString()),
                                  TableComponents.cell(album.id.toString()),
                                  TableComponents.cell(album.title.toString())
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
