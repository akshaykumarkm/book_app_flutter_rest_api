import 'package:flutter/material.dart';

final ThemeData mainTheme = ThemeData(
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      textStyle: WidgetStatePropertyAll(
        TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      padding: WidgetStatePropertyAll(EdgeInsets.all(15)),
      backgroundColor: WidgetStatePropertyAll(Colors.deepOrange),
      foregroundColor: WidgetStatePropertyAll(Colors.white),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.deepOrange),
      borderRadius: BorderRadius.circular(30),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.deepOrange),
      borderRadius: BorderRadius.circular(30),
    ),
    focusColor: Colors.deepOrange,
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.deepOrange),
      borderRadius: BorderRadius.circular(30),
    ),
  ),
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
);
