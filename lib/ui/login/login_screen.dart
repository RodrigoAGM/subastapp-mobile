import 'package:flutter/material.dart';
import 'package:subastapp/ui/animation/FadeAnimation.dart';
import 'package:subastapp/bloc/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subastapp/ui/login/login_states.dart';
import 'package:subastapp/ui/login/login_events.dart';
import 'package:page_transition/page_transition.dart';
import 'package:subastapp/ui/register/register_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  LoginBloc _loginBloc;
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _emailFocus = FocusNode();
  final _passFocus = FocusNode();

  @override 
  void initState() {
    super.initState();
    _loginBloc = LoginBloc();
    _loginBloc.dispatch(LoginEventInitSignIn(context));
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

                if(state.error){
                  
                  Fluttertoast.showToast(
                      msg: "Email or password incorrect",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIos: 1,
                      backgroundColor: Colors.red.withOpacity(.6),
                      textColor: Colors.white,
                      fontSize: 12.0
                  );
                  state.error=false;
                }

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
                              child: TextFormField(
                                focusNode: _emailFocus,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (value){
                                  _fieldFocusChange(context, _emailFocus, _passFocus);
                                },
                                controller: _emailController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(color: Colors.grey.withOpacity(.8)),
                                  hintText: "Email"
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                              ),
                              child: TextFormField(
                                focusNode: _passFocus,
                                textInputAction: TextInputAction.done,
                                controller: _passController,
                                obscureText: true,
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
                      SizedBox(height: 40.0,),
                      FadeAnimation(1.8, Center(
                        child: Column(
                          children: <Widget>[
                            RaisedButton(
                              onPressed: (){
                                var pass = _passController.text;
                                var email = _emailController.text;
                                if (pass.isEmpty || email.isEmpty){
                                  setState(() {
                                    Fluttertoast.showToast(
                                      msg: "All fields must be completed",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIos: 1,
                                      backgroundColor: Colors.red.withOpacity(.6),
                                      textColor: Colors.white,
                                      fontSize: 12,
                                    );
                                  });
                                }else{
                                  _loginBloc.dispatch(LoginEventSignIn(context, email, pass));
                                }
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

              if (state is LoginStateLoading){
                return Center(
                  child: CircularProgressIndicator(),
                );  
              }

              if (state is LoginStateError){
                return Center(
                  child: Text(
                    'Connection error!',
                    style: TextStyle(
                      color: Colors.red.withOpacity(1), 
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );  
              }
            },
          ),
        )
      ),
    );
  }

  _fieldFocusChange(BuildContext context, FocusNode currentFocus,FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);  
  }
}