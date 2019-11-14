import 'package:flutter/material.dart';
import 'package:subastapp/ui/animation/FadeAnimation.dart';
import 'package:subastapp/ui/bloc/register_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subastapp/ui/register/register_events.dart';
import 'package:subastapp/ui/register/register_states.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterPage extends StatefulWidget {
  
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  RegisterBloc _registerBloc;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmController = TextEditingController();
  final FocusNode _nameFocus = FocusNode();  
  final FocusNode _emailFocus = FocusNode();  
  final FocusNode _passFocus = FocusNode();
  final FocusNode _confirmFocus = FocusNode();

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
                            child: TextFormField(
                              textInputAction: TextInputAction.next,
                              autofocus: true,
                              focusNode: _nameFocus,
                              controller: _nameController,
                              onFieldSubmitted: (value){
                                _fieldFocusChange(context, _nameFocus, _emailFocus);
                              },
                              textCapitalization: TextCapitalization.words,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(color: Colors.grey.withOpacity(.8)),
                                hintText: "Full name",
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: Colors.grey[300]))
                            ),
                            child: TextFormField(
                              focusNode: _emailFocus,
                              onFieldSubmitted: (value){
                                _fieldFocusChange(context, _emailFocus, _passFocus);
                              },
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                              controller: _emailController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(color: Colors.grey.withOpacity(.8)),
                                hintText: "Email",
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: Colors.grey[300]))
                            ),
                            child: TextFormField(
                              focusNode: _passFocus,
                              onFieldSubmitted: (value){
                                _fieldFocusChange(context, _passFocus, _confirmFocus);
                              },
                              textInputAction: TextInputAction.next,
                              obscureText: true,
                              controller: _passController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(color: Colors.grey.withOpacity(.8)),
                                hintText: "Password",
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                            ),
                            child: TextFormField(
                              focusNode: _confirmFocus,
                              textInputAction: TextInputAction.done,
                              controller: _confirmController,
                              obscureText: true,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(color: Colors.grey.withOpacity(.8)),
                                hintText: "Confirm password",
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
                              var confirm = _confirmController.text;
                              var pass = _passController.text;
                              var name = _nameController.text;
                              var email = _emailController.text;
                              if (confirm.isEmpty || pass.isEmpty || name.isEmpty || email.isEmpty){
                                setState(() {
                                  Fluttertoast.showToast(
                                      msg: "All fields must be completed!",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIos: 1,
                                      backgroundColor: Colors.red.withOpacity(.6),
                                      textColor: Colors.white,
                                      fontSize: 12.0
                                  );
                                });
                              }else if (confirm != pass){
                                setState(() {
                                  Fluttertoast.showToast(
                                      msg: "Passwords don't match!",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIos: 1,
                                      backgroundColor: Colors.red.withOpacity(.6),
                                      textColor: Colors.white,
                                      fontSize: 12.0
                                  );
                                });
                              }else{
                                _registerBloc.dispatch(RegisterEventRegister(context, name, email, pass));
                              }
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

            if (state is RegisterStateLoading){
              return Center(
                child: CircularProgressIndicator(),
              );  
            }

            if (state is RegisterStateError){
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
        )
      )
    );
  }

  _fieldFocusChange(BuildContext context, FocusNode currentFocus,FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);  
  }
}
