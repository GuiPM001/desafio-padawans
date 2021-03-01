import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class ToDos {
  int userId;
  int id;
  String title;
  bool completed;

  ToDos({this.userId, this.id, this.title, this.completed});

  factory ToDos.fromJson(Map<String, dynamic> json) {
    return ToDos(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      completed: json['completed'],
    );
  }
}

Future<List<ToDos>> fetchToDos() async {
  final response = await http.get('https://jsonplaceholder.typicode.com/todos');

  if (response.statusCode == 200) {
    var parsed = json.decode(response.body);

    List jsonReponse = parsed as List;

    return jsonReponse.map((list) => new ToDos.fromJson(list)).toList();
  } else {
    print('Error, could not load data.');
  }
}

class ToDosTable extends StatefulWidget {
  @override
  _ToDosTableState createState() => _ToDosTableState();
}

class _ToDosTableState extends State<ToDosTable> {
  Future<List<ToDos>> _func;

  @override
  void initState() {
    _func = fetchToDos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<ToDos>>(
        future: _func,
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            List<ToDos> data = snapshot.data;
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
                          'TO-DOs',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )),
                  ]),
                  Container(
                    child: SingleChildScrollView(
                      child: DataTable(
                        columnSpacing: 25,
                        dataRowHeight: 100,
                        headingTextStyle: TextStyle(
                            color: Colors.green[600],
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
                          DataColumn(
                            label: Text(
                              'Completado',
                            ),
                            numeric: false,
                          ),
                        ],
                        rows: data
                            .map(
                              (todo) => DataRow(
                                cells: [
                                  DataCell(
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        todo.userId.toString(),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        todo.id.toString(),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        todo.title.toString(),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        todo.completed.toString(),
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
