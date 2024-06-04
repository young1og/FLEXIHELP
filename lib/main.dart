import 'package:flexihelp/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flexihelp/SettingsPage.dart';
void main() {
  runApp(MyApp());
}

ThemeData getAppTheme() => ThemeData(
  primaryColor: Colors.black, // Добавляем золотистый акцент
  scaffoldBackgroundColor: Colors.black, // Цвет фона экрана
  textTheme: TextTheme(
    headline1: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    // Используем более красивые шрифты
    headline2: TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.amber),
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getAppTheme(),
      home: SplashScreen(),
    );
  }
}














