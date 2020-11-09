import 'package:MissingReport/after_form_screen.dart';
import 'package:MissingReport/complaint_form.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:firebase_core/firebase_core.dart';
import './login.dart';
import './splash.dart';
import 'homescreen.dart';
import 'search_missing.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        LoginScreen.routeName: (ctx) => LoginScreen(),
        HomeScreen.routeName: (ctx) => HomeScreen(),
        ComplaintForm.routeName: (ctx) => ComplaintForm(),
        AfterForm.routeName: (ctx) => AfterForm(),
        SearchMissing.routeName: (ctx) => SearchMissing(),
      },
    );
  }
}
