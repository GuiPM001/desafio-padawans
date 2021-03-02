import 'package:flutter/material.dart';

class Header extends StatefulWidget {
  final String titleTable;
  Header({this.titleTable});

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
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
              '${widget.titleTable}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
      ],
    );
  }
}
