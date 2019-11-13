import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:subastapp/init_screens/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Welcome to Subastapp',
      home: InitScreen(),
    );
  }
}

class InitScreen extends StatefulWidget {
  InitScreen({Key key}) : super(key: key);

  @override
  _InitScreenState createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {

  Future checkOnBoarding() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _logged = (prefs.getBool('_logged') ?? true);

    if (_logged) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new Splash()));
    } else {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new Splash()));
    }

  }

  @override
  void initState() {
    super.initState();
    new Timer(new Duration(milliseconds: 200), () {
      checkOnBoarding();
    });
  }

  @override
  Widget build(BuildContext context) {
      return new Scaffold(
      body: new Center(
          child: new CircularProgressIndicator(),
      ),
      );
  }
}