import 'package:flutter/material.dart';
import 'package:subastapp/ui/home/HomePage/home_page.dart';
import 'package:subastapp/ui/home/PerfilPage/perfil_page.dart';
import 'package:subastapp/ui/home/ShoppingPage/shopping_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentTabIndex = 0;

  onTapped(int index) {
    setState(() {
      currentTabIndex = index;
    });
  }

  List<Widget> tabs = [
    ShoppingPage(),
    HomePage(),
    PerfilPage(),
  ];

  @override
  void initState() {
    currentTabIndex = 1;
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
          actions: <Widget>[
            FutureBuilder(
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (currentTabIndex == 1) {
                  return IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      findProduct(context);
                    },
                    color: Theme.of(context).accentColor,
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
        body: tabs[currentTabIndex],
        bottomNavigationBar: BottomNavigationBar(
            onTap: onTapped,
            currentIndex: currentTabIndex,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.local_grocery_store),
                  title: Text('Shopping')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.gavel), title: Text('Home')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), title: Text('Settings'))
            ]));
  }


  findProduct(BuildContext context){
    TextEditingController customController=TextEditingController();

    return showDialog(context: context,builder: (context){
      return AlertDialog(
        title: Text("¿Qué deseas buscar?"),
        content: TextField(
          controller: customController,
        ),
        actions: <Widget>[
          MaterialButton(
            elevation: 5.0,
            child: Text("Buscar"),
            onPressed: (){
              Navigator.of(context).pop(customController.text.toString());
            },
          )
        ],
      );
    });
  }


}


