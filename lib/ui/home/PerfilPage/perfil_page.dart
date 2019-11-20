import 'package:flutter/material.dart';
import 'package:subastapp/ui/home/PerfilPage/add_shop/add_shop_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:subastapp/ui/login/login_screen.dart';

final _storage = new FlutterSecureStorage();

class PerfilPage extends StatelessWidget {
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
          IconButton(
            icon: Icon(Icons.exit_to_app, color: Theme.of(context).accentColor,),
            onPressed: () {
              _logout(context);
            },
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder(
          future: _getStore(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData && snapshot.data != "none") {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      child: Text(
                        "Log out",
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () {
                        _logout(context);
                      },
                    ),
                  ],
              );
            } else if (snapshot.data == "none") {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      child: Text("Add Store"),
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                child: AddShopPage()));
                      },
                    ),
                    RaisedButton(
                      child: Text(
                        "Log out",
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () {
                        _logout(context);
                      },
                    ),
                  ],
                );
            } else {
              return RefreshProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}

Future<String> _getStore() async {
  return (await _storage.read(key: 'store') == ""
      ? "none"
      : await _storage.read(key: 'store'));
}

void _logout(BuildContext context) {
  _storage.deleteAll();
  Navigator.pushReplacement(context,
      PageTransition(type: PageTransitionType.fade, child: LoginPage()));
}
