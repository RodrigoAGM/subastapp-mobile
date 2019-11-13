import 'package:flutter/material.dart';
import 'package:subastapp/ui/animation/FadeAnimation.dart';
import 'package:subastapp/ui/bloc/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subastapp/ui/login/login_states.dart';
import 'package:subastapp/ui/login/login_events.dart';
import 'package:page_transition/page_transition.dart';
import 'package:subastapp/ui/register/register_screen.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  LoginBloc _loginBloc;

  @override 
  void initState() {
    super.initState();
    _loginBloc = LoginBloc();
  }

  @override
  void dispose() {
    super.dispose();
    _loginBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return BlocProvider<LoginBloc>(
      bloc: _loginBloc,
      child: Scaffold(
        backgroundColor: Color.fromRGBO(25,118,210, 1),
        body: Container(
          child: BlocBuilder<LoginEvent, LoginState>(
            bloc:_loginBloc,
            builder: (BuildContext context, LoginState state) {
              if(state is LoginStateDefault){
                return Container(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FadeAnimation(1.2, Text("Login", 
                      style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),)),
                      SizedBox(height: 30,),
                      FadeAnimation(1.5, Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Colors.grey[300]))
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(color: Colors.grey.withOpacity(.8)),
                                  hintText: "Email or Phone number"
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(color: Colors.grey.withOpacity(.8)),
                                  hintText: "Password"
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                      SizedBox(height: 40,),
                      FadeAnimation(1.8, Center(
                        child: Column(
                          children: <Widget>[
                            RaisedButton(
                              onPressed: (){

                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(50),
                              ),
                              color: Colors.blue[900],
                              child: Container(
                                width: 120,
                                padding: EdgeInsets.all(15),
                                child: Center(child: Text("Login", style: TextStyle(color: Colors.white.withOpacity(.8)),)),
                              ),
                            ),

                            RaisedButton(
                              onPressed: (){
                                Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: RegisterPage()));
                              },
                              color: Colors.transparent,
                              elevation: 0,
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              highlightElevation: 0,
                              child: Container(
                                width: 150,
                                padding: EdgeInsets.all(15),
                                child: Center(child: Text("Not registered yet?", style: TextStyle(color: Colors.white.withOpacity(.8)),)),
                              ),
                            ),
                          ],
                        )
                      )),
                    ],
                  ),
                );
              }
            },
          ),
        )
      ),
    );
  }
}