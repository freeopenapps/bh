import 'package:flutter/material.dart';

final appTheme = ThemeData(
    primarySwatch: Colors.blueGrey,
    buttonColor: Colors.red.shade300,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: Colors.red.shade300,
        side: BorderSide(
          width: 0.5,
          color: Colors.black,
        ),
      ),
    ),
    textTheme: TextTheme(
      button: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      headline1: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.w500,
      ),
      headline2: TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.w300,
      ),
      bodyText1: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w200,
      ),
      bodyText2: TextStyle(
        fontSize: 10.0,
        fontWeight: FontWeight.w100,
      ),
    ));
