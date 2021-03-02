import 'package:flutter/material.dart';

class TableComponents {
  static column(String nameColumn, bool numeric) {
    return DataColumn(
        label: Text(
          nameColumn,
          textAlign: TextAlign.center,
        ),
        numeric: numeric);
  }

  static cell(String dado) {
    return DataCell(Container(
      alignment: Alignment.centerLeft,
      child: Text(dado),
    ));
  }
}
