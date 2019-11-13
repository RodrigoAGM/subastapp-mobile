import 'package:flutter/material.dart';
import 'package:subastapp/animation/FadeAnimation.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(25,118,210, 1),
      body: Container(
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
      ),
    );
  }
}