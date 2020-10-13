import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import './login.dart';
import './splash.dart';
import 'homescreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          textTheme: TextTheme(headline1: TextStyle(fontFamily: 'Montserrat')),
          primaryColor: Hexcolor('#194A6D'),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          accentColor: Hexcolor('#F2F5F6'), //
          backgroundColor: Colors.white,
          fontFamily: 'Montserrat'),
      home: SplashScreen(),
      routes: {
        '/loginscreen': (ctx) => LoginScreen(),
        HomeScreen.routeName: (ctx) => HomeScreen(),
      },
    );
  }
}
