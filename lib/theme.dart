import 'package:flutter/material.dart';

ThemeData mediumTheme(mode) {
  TextTheme _textTheme(TextTheme base) {
    return base.copyWith(
      headline1: base.headline1.copyWith(
        fontFamily: 'Roboto',
        fontSize: 22.0,
        color: Colors.red,
      ),
      headline2: base.headline2.copyWith(
        fontFamily: 'Roboto',
        fontSize: 18.0,
        color: Colors.green,
      ),
      headline3: base.headline3.copyWith(
        fontFamily: 'Roboto',
        fontSize: 14.0,
        color: Colors.black,
      ),
      bodyText1: base.bodyText1.copyWith(
        fontFamily: 'Roboto',
        fontSize: 3.0,
        color: Colors.orange,
      ),
      bodyText2: base.bodyText2.copyWith(
        fontFamily: 'Roboto',
        fontSize: 3.0,
        color: Colors.pink,
      ),
    );
  }

  ThemeData base;
  if (mode == 'light') {
    base = ThemeData.light();
  } else {
    base = ThemeData.dark();
  }

  // final ThemeData base = ThemeData.dark();
  return base.copyWith(
      textTheme: _textTheme(base.textTheme),
      // primaryColor: Colors.amber,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              // backgroundColor: Colors.red,
              )),
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.orange,
      ));
}

ThemeData redrum() {
  return ThemeData(
    primarySwatch: Colors.amber,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.orange,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: Colors.red.shade300,
        textStyle: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 18.0,
          fontWeight: FontWeight.normal,
        ),
        side: BorderSide(
          width: 0.5,
          color: Colors.black,
        ),
      ),
    ),
    textTheme: TextTheme(
      button: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        // color: Colors.white,
        backgroundColor: Colors.blue,
        decorationColor: Colors.blue,
      ),
      headline1: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      headline2: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 18.0,
        fontWeight: FontWeight.w500,
      ),
      headline3: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
      ),
      bodyText1: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 14.0,
        fontWeight: FontWeight.w200,
      ),
      bodyText2: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 10.0,
        fontWeight: FontWeight.w100,
      ),
    ),
  );
}

// primarySwatch: Colors.grey,
// buttonColor: Colors.red.shade300,
// elevatedButtonTheme: ElevatedButtonThemeData(
//   style: ElevatedButton.styleFrom(
//     primary: Colors.red.shade300,
//     side: BorderSide(
//       width: 0.5,
//       color: Colors.black,
//     ),
//   ),
// ),
// textTheme: TextTheme(
//   button: TextStyle(
//     fontSize: 18.0,
//     fontWeight: FontWeight.w400,
//     color: Colors.white,
//   ),
//   headline1: TextStyle(
//     fontSize: 32.0,
//     fontWeight: FontWeight.w500,
//   ),
//   headline2: TextStyle(
//     fontSize: 22.0,
//     fontWeight: FontWeight.w300,
//   ),
//   headline3: TextStyle(
//     fontSize: 1.0,
//     fontWeight: FontWeight.w100,
//   ),
//   bodyText1: TextStyle(
//     fontSize: 14.0,
//     fontWeight: FontWeight.w200,
//   ),
//   bodyText2: TextStyle(
//     fontSize: 10.0,
//     fontWeight: FontWeight.w100,
//   ),
// ),
// );
