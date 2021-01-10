import 'package:flutter/material.dart';

class MyStyle {
  Color darkBackgroud = Color(0xff3C444D);
  Color buttonColor1 = Colors.purpleAccent[400];

  Widget showProgress() {
    return Center(child: CircularProgressIndicator());
  }

  RoundedRectangleBorder roundType1() {
    return RoundedRectangleBorder(
      side: BorderSide(
        width: 1,
        color: Colors.white,
      ),
      borderRadius: BorderRadius.circular(30),
    );
  }

  BoxDecoration boxDecorationTextField() {
    return BoxDecoration(color: Colors.white);
  }

  BoxDecoration boxDecorationTextField2() {
    return BoxDecoration(
      color: Colors.grey.shade300,
      borderRadius: BorderRadius.circular(18),
    );
  }

  TextStyle titelH1() {
    return TextStyle(
      fontSize: 30,
      color: Colors.white,
    );
  }

  TextStyle titelH2() {
    return TextStyle(
      fontSize: 14,
      color: Colors.white,
    );
  }

  TextStyle titelH2red() {
    return TextStyle(
      fontSize: 14,
      color: Colors.redAccent[400],
    );
  }

TextStyle titelH2green() {
    return TextStyle(
      fontSize: 14,
      color: Colors.green[300],
    );
  }



 TextStyle titelH3() {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
  }

  MyStyle();
}
