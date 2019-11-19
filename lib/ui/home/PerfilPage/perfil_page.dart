import 'package:flutter/material.dart';
import 'package:subastapp/ui/home/PerfilPage/add_shop/add_shop_page.dart';
import 'package:page_transition/page_transition.dart';

class PerfilPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {      
    return Scaffold(
      body: Center(   
        child: RaisedButton(
          child: Text("Add Store"),
          onPressed: (){
            Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: AddShopPage()));
          },
        ),
      ),
    );
  }

}