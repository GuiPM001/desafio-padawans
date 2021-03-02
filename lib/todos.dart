import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'components/header.dart';
import 'components/tableComponents.dart';
import 'components/loading.dart';

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
                  Header(titleTable: "TO-DOs"),
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
                          TableComponents.column('Id do \nUsuário', true),
                          TableComponents.column('Id', true),
                          TableComponents.column('Título', false),
                          TableComponents.column('Completado', false)
                        ],
                        rows: data
                            .map(
                              (todo) => DataRow(
                                cells: [
                                  TableComponents.cell(todo.userId.toString()),
                                  TableComponents.cell(todo.id.toString()),
                                  TableComponents.cell(todo.title.toString()),
                                  TableComponents.cell(
                                      todo.completed.toString())
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
