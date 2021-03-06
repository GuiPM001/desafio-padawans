import 'package:flutter/material.dart';

class TableComponent {
  static column(String columnName, bool numeric) {
    return DataColumn(
        label: Text(
          columnName,
          textAlign: TextAlign.center,
        ),
        numeric: numeric);
  }

  static cell(String data) {
    return DataCell(Container(
      alignment: Alignment.centerLeft,
      child: Text(data),
    ));
  }
}
