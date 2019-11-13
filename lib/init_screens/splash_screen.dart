import 'dart:async';    
import 'package:flutter/material.dart';
import 'package:subastapp/login/login_screen.dart';    

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => new _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    new Future.delayed(
        const Duration(seconds: 2),
        () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            ));
  }

  @override
  Widget build(BuildContext context) {
    
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromRGBO(48, 53, 169, 1),
      body: Container(
        width: double.infinity,
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Positioned(
              top: -50,
              left: 0,
              child: Container(
                width: width,
                height: 400,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/one.png'),
                    fit: BoxFit.cover
                  )
                ),
              ),
            ),
            Positioned(
              top: -100,
              left: 0,
              child: Container(
                width: width,
                height: 400,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/one.png'),
                    fit: BoxFit.cover
                  )
                ),
              ),
            ),
            Positioned(
              top: -150,
              left: 0,
              child: Container(
                width: width,
                height: 400,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/one.png'),
                    fit: BoxFit.cover
                  )
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Center(
                      child: new Image(
                        image: AssetImage('assets/icon.png'),
                        height: MediaQuery.of(context).size.height/4,
                      )
                    ),                  
                  ),
                  SizedBox(height: 20,),
                  Container(
                    child: Center(
                      child: Text(
                        "Subastapp", 
                        style: TextStyle(
                          color: Colors.white.withOpacity(.7), 
                          height: 1.4, 
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}