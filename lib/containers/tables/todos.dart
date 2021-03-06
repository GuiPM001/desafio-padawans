import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../components/header.dart';
import '../../components/loading.dart';
import '../../components/tableComponent.dart';

class ToDos {
  int id;
  int userId;
  String title;
  bool done;

  ToDos({this.userId, this.id, this.title, this.done});

  factory ToDos.fromJson(Map<String, dynamic> json) {
    return ToDos(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      done: json['completed'],
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
                  Header(titleTable: "To-Dos"),
                  Container(
                    child: SingleChildScrollView(
                      child: DataTable(
                        columnSpacing: 36,
                        dataRowHeight: 100,
                        headingTextStyle: TextStyle(
                            color: Colors.green[600],
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                        columns: [
                          TableComponent.column('Id', true),
                          TableComponent.column('User-id', true),
                          TableComponent.column('Title', false),
                          TableComponent.column('Done', false)
                        ],
                        rows: data
                            .map(
                              (todo) => DataRow(
                                cells: [
                                  TableComponent.cell(todo.id.toString()),
                                  TableComponent.cell(todo.userId.toString()),
                                  TableComponent.cell(todo.title.toString()),
                                  TableComponent.cell(todo.done.toString())
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
