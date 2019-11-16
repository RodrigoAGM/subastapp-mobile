import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:subastapp/ui/init_screens/onboarding_screen.dart';
import 'package:subastapp/ui/init_screens/splash_screen.dart';
import 'package:bloc/bloc.dart';
import 'ui/home/home_screen.dart';

class BlocMainDelegate extends BlocDelegate {

  @override
  void onError(Object error, StackTrace stackTrace) {
    print(error);
  }

  @override
  void onTransition(Transition transition) {
    print(transition);
  }
}

void main() {
  BlocSupervisor().delegate = BlocMainDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Welcome to Subastapp',
      home: MainPage(),
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
    bool _show = (prefs.getBool('show') ?? true);
    if (_show) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new Onboarding()));
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