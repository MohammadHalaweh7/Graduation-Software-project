import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData darkTheme = ThemeData (
  scaffoldBackgroundColor: HexColor("333739"),
  primarySwatch: Colors.deepOrange,
  appBarTheme:AppBarTheme(
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
    backgroundColor: HexColor("333739"),
    elevation: 0.0,
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor:  HexColor("333739"),
      statusBarIconBrightness: Brightness.light,

    ),


  ) ,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.deepOrange,
      elevation: 20.0,
      backgroundColor:  HexColor("333739"),
      unselectedItemColor: Colors.grey


  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.deepOrange
  ),
  textTheme: TextTheme(
      bodyText1: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white
      )
  ),
  // fontFamily:'myFont',
);

ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.deepOrange,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme:AppBarTheme(
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),
    backgroundColor: Colors.white,
    elevation: 0.0,
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,

    ),


  ) ,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.deepOrange,
      elevation: 20.0,
      backgroundColor:  Colors.white,
      unselectedItemColor: Colors.grey

  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.deepOrange
  ),
  textTheme: TextTheme(
      bodyText1: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black
      )
  ),
  // fontFamily:'myFont',


);