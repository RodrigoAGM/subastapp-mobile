import 'package:flutter/material.dart';
import 'package:subastapp/ui/home/PerfilPage/add_shop/add_shop_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:subastapp/ui/login/login_screen.dart';

final _storage = new FlutterSecureStorage();

class PerfilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
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
