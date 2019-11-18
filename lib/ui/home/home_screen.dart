import 'package:flutter/material.dart';
import 'package:subastapp/ui/home/HomePage/home_page.dart';
import 'package:subastapp/ui/home/PerfilPage/perfil_page.dart';
import 'package:subastapp/ui/home/ShoppingPage/shopping_page.dart';

class MainPage extends StatefulWidget{
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>{

  int currentTabIndex=0;

  onTapped(int index){
    setState(() {
      currentTabIndex=index;
    });
  }

  List<Widget> tabs=[
    ShoppingPage(),
    HomePage(),
    PerfilPage(),
  ];


  @override
  void initState() {
    super.initState();
  }


  @override
  void dispose() {
    super.dispose();
  }

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
      ),
      body:tabs[currentTabIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTapped,
        currentIndex: currentTabIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.local_grocery_store),
            title:Text('Shopping')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.gavel),
            title:Text('Home')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title:Text('Settings')
          )
        ]
      )
    );
  }

}