import 'package:flutter/material.dart';
import 'package:subastapp/model/customer.dart';
import 'package:subastapp/network/customer_api.dart';
import 'package:subastapp/ui/home/PerfilPage/add_shop/add_shop_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:subastapp/ui/login/login_screen.dart';

final _storage = new FlutterSecureStorage();
final _customerApi = new CustomerApi();

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
            icon: Icon(
              Icons.exit_to_app,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () {
              _logout(context);
            },
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder(
          future: _getCustomer(),
          builder: (BuildContext context, AsyncSnapshot user) {
            if(user.hasData){
              return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Container(
                  margin: EdgeInsets.only(top: 10.0, bottom:10.0),
                  height: MediaQuery.of(context).size.width/1.5,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    
                    border: Border.all(width: 3,color: Colors.black,)

                  ),
                  child: Image(
                    image: (user.data.image != null) ? NetworkImage(user.data.image) : AssetImage('assets/user.png'),
                    ),
                ),

                FutureBuilder(
                  future: _getStore(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData && snapshot.data != "none") {
                      return LogoutButton();
                    } else if (snapshot.data == "none") {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ButtonTheme(
                            minWidth: MediaQuery.of(context).size.width / 1.5,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(50),
                              ),
                              color: Colors.blue[600],
                              child: Container(
                                width: 120,
                                padding: EdgeInsets.all(15),
                                child: Center(
                                    child: Text(
                                  "Add Store",
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(.8),
                                      fontWeight: FontWeight.bold),
                                )),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.fade,
                                        child: AddShopPage()));
                              },
                            ),
                          ),
                          LogoutButton()
                        ],
                      );
                    } else {
                      return RefreshProgressIndicator();
                    }
                  },
                ),
              ]);
            }

            return CircularProgressIndicator();
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

Future<Customer> _getCustomer() async {
  var id = await _storage.read(key: 'userId');
  return await _customerApi.getById(id);
}

void _logout(BuildContext context) {
  _storage.deleteAll();
  Navigator.pushReplacement(context,
      PageTransition(type: PageTransitionType.fade, child: LoginPage()));
}

class LogoutButton extends StatelessWidget {
  const LogoutButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: MediaQuery.of(context).size.width / 1.5,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(50),
        ),
        color: Colors.red[700],
        child: Container(
          width: 120,
          padding: EdgeInsets.all(15),
          child: Center(
              child: Text(
            "Logout",
            style: TextStyle(
                color: Colors.white.withOpacity(.8),
                fontWeight: FontWeight.bold),
          )),
        ),
        onPressed: () {
          _logout(context);
        },
      ),
    );
  }
}
