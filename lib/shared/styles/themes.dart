import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: HexColor("333739"),
  primarySwatch: Colors.deepOrange,
  appBarTheme: AppBarTheme(
    actionsIconTheme: IconThemeData(color: Colors.white),
    textTheme: TextTheme(
      headline5: TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    ),
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
        color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
    backgroundColor: HexColor("333739"),
    elevation: 0.0,
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor("333739"),
      statusBarIconBrightness: Brightness.light,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.deepOrange,
      elevation: 20.0,
      backgroundColor: HexColor("333739"),
      unselectedItemColor: Colors.grey),
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: Colors.deepOrange),

  textTheme: const TextTheme(
    bodyText1: TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
    subtitle2: TextStyle(fontSize: 15.0, color: Colors.white),
    subtitle1: TextStyle(fontSize: 13, color: Colors.white),
    bodyText2: TextStyle(
        fontSize: 17,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.bold,
        color: Colors.white),
    headline5: TextStyle(
      color: Colors.white,
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
  ),
  // fontFamily:'myFont',
);

//------------------------------------------------------------------------------

ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.deepOrange,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    actionsIconTheme: IconThemeData(color: Colors.black),
    iconTheme: IconThemeData(color: Colors.blue),
    titleTextStyle: TextStyle(
        color: Colors.blue, fontSize: 22, fontWeight: FontWeight.bold),
    backgroundColor: Colors.white,
    elevation: 0.0,
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.deepOrange,
      elevation: 20.0,
      backgroundColor: Colors.white,
      unselectedItemColor: Colors.grey),
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: Colors.deepOrange),
  textTheme: TextTheme(
      bodyText1: TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),

  // fontFamily:'myFont',
);
