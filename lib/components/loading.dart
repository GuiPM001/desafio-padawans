import 'package:flutter/material.dart';

class Loading {
  static loadingScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
