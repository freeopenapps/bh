import 'package:flutter/material.dart';

final mediumTheme = ThemeData(
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
      headline3: TextStyle(
        fontSize: 1.0,
        fontWeight: FontWeight.w100,
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

final smallTheme = ThemeData(
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
        fontSize: 12.0,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      headline1: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w500,
      ),
      headline2: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w300,
      ),
      bodyText1: TextStyle(
        fontSize: 10.0,
        fontWeight: FontWeight.w200,
      ),
      bodyText2: TextStyle(
        fontSize: 6.0,
        fontWeight: FontWeight.w100,
      ),
    ));
