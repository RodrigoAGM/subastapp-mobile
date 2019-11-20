import 'package:flutter/material.dart';


class ShoppingPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "SubastApp",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 1,
        actions: <Widget>[
          
        ],
      ),
      body: Center(
        child: Text("Shopping Page"),
      ),
    );
  }

}