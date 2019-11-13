import 'package:flutter/material.dart';
import 'package:subastapp/ui/animation/FadeAnimation.dart';
import 'package:subastapp/ui/bloc/register_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subastapp/ui/register/register_events.dart';
import 'package:subastapp/ui/register/register_states.dart';

class RegisterPage extends StatefulWidget {
  
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  RegisterBloc _registerBloc;

  @override
  void initState() {
    super.initState();
    _registerBloc = RegisterBloc();
  }

  @override
  void dispose(){
    super.dispose();
    _registerBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return BlocProvider<RegisterBloc>(
      bloc: _registerBloc,
      child: Scaffold(
        backgroundColor: Color.fromRGBO(25,118,210, 1),
        body: BlocBuilder<RegisterEvent, RegisterState>(
          bloc: _registerBloc,
          builder: (context, state) {

            if(state is RegisterStateDefault){
              return Container(
                padding: EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FadeAnimation(1.2, Text("Register", 
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
                                hintText: "Name"
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: Colors.grey[300]))
                            ),
                            child: TextField(
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
                              child: Center(child: Text("Register", style: TextStyle(color: Colors.white.withOpacity(.8)),)),
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
        )
      )
    );
  }
}
