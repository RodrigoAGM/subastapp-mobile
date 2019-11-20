import 'package:flutter/material.dart';
import 'package:subastapp/ui/home/HomePage/home_page.dart';
import 'package:subastapp/ui/home/PerfilPage/perfil_page.dart';
import 'package:subastapp/ui/home/ShoppingPage/shopping_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:subastapp/ui/home/StorePage/store_screen.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentTabIndex = 0;
  final _secure = new FlutterSecureStorage();

  onTapped(int index) {
    setState(() {
      currentTabIndex = index;
    });
  }

  List<Widget> tabs;

  List<BottomNavigationBarItem> items;
  List<BottomNavigationBarItem> extra;

  @override
  void initState() {
    currentTabIndex = 1;
    super.initState();
    tabs = [
      ShoppingPage(),
      HomePage(),
      PerfilPage(),
    ];
    items = [
      BottomNavigationBarItem(
          icon: Icon(Icons.local_grocery_store), title: Text('Shopping')),
      BottomNavigationBarItem(icon: Icon(Icons.gavel), title: Text('Home')),
      BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('Settings'))
    ];
    if (_secure.read(key: 'store') != null) {
      tabs = tabs = [
        StorePage(),
        HomePage(),
        PerfilPage(),
      ];
      extra = [
        BottomNavigationBarItem(icon: Icon(Icons.store), title: Text('Store')),
        BottomNavigationBarItem(icon: Icon(Icons.gavel), title: Text('Home')),
        BottomNavigationBarItem(
            icon: Icon(Icons.person), title: Text('Settings'))
      ];
    }
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
                    onPressed: () {},
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
            items: (tabs.length == 4) ? (extra) : items));
  }
}
