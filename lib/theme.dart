import 'package:flutter/material.dart';

ThemeData mobileTheme() {
  return ThemeData(
    primarySwatch: Colors.teal,
    scaffoldBackgroundColor: Colors.teal.shade50,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.orange,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: Colors.orange,
        side: BorderSide(
          width: 0.5,
          color: Colors.black,
        ),
      ),
    ),
    textTheme: TextTheme(
      button: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 18.0,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      headline1: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 22.0,
        fontWeight: FontWeight.bold,
      ),
      headline2: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
      ),
      headline3: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 15.0,
        fontWeight: FontWeight.w600,
      ),
      headline4: TextStyle(
        // fontFamily: 'OpenSans',
        fontSize: 24.0,
        fontWeight: FontWeight.w500,
      ),
      bodyText1: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 10.0,
        fontWeight: FontWeight.w200,
      ),
      bodyText2: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 8.0,
        fontWeight: FontWeight.w100,
      ),
    ),
  );
}
