import 'package:flutter/material.dart';

class NavTableButton {
  static button(Color colorButton, String buttonName, BuildContext context,
      Widget openPage) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: colorButton,
        onPrimary: Colors.white,
        minimumSize: Size(120, 100),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      child: Text(
        buttonName,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      ),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => openPage));
      },
    );
  }
}
