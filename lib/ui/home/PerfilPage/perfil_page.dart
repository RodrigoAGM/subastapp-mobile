import 'package:flutter/material.dart';
import 'package:subastapp/ui/home/PerfilPage/add_shop/add_shop_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final _storage = new FlutterSecureStorage();

class PerfilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: _getStore(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData && snapshot.data != "none") {
              return Container();
            }else{
              return RaisedButton(
                child: Text("Add Store"),
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade, child: AddShopPage()));
                },
              );
            }
          },
        ),
      ),
    );
  }
}

Future<String> _getStore() async {
  return (await _storage.read(key: 'store') == null
      ? "none"
      : await _storage.read(key: 'store'));
}
