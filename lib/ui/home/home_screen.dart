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

  Future<String> _getStore() async{
    return await _secure.read(key: 'store');
  }

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
    if (_secure.read(key: 'store') != "") {
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
        
        body: FutureBuilder(
          future: _getStore(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData && snapshot.data == ""){
              tabs.clear();
              tabs = [ShoppingPage(), HomePage(),PerfilPage()];
              return tabs[currentTabIndex];
            }else if (snapshot.hasData && snapshot.data != ""){
              tabs.clear();
              tabs = [StorePage(), ShoppingPage(), HomePage(),PerfilPage()];
              return tabs[currentTabIndex];
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
        bottomNavigationBar: FutureBuilder(
          future: _getStore(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {

            if(snapshot.hasData && snapshot.data == ""){
              items = [
                BottomNavigationBarItem(icon: Icon(Icons.local_grocery_store), title: Text('Shopping')),
                BottomNavigationBarItem(icon: Icon(Icons.gavel), title: Text('Home')),
                BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('Settings'))
              ];
              return BottomNavigationBar(
                onTap: onTapped,
                currentIndex: currentTabIndex,
                items: items
              );
            }else if(snapshot.hasData && snapshot.data != ""){
              items = [
                BottomNavigationBarItem(icon: Icon(Icons.store), title: Text('Store')),
                BottomNavigationBarItem(icon: Icon(Icons.local_grocery_store), title: Text('Shopping')),
                BottomNavigationBarItem(icon: Icon(Icons.gavel), title: Text('Home')),
                BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('Settings'))
              ];
              return BottomNavigationBar(
                selectedItemColor: Theme.of(context).accentColor,
                unselectedItemColor: Theme.of(context).hintColor,
                showUnselectedLabels: true,
                onTap: onTapped,
                currentIndex: currentTabIndex,
                items: items
              );
            }

            return Center(child: CircularProgressIndicator(),);
          },
        ),
    );
  }
}


