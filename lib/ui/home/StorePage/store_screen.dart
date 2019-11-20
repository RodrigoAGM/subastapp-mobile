import 'package:flutter/material.dart';
import 'package:subastapp/model/store.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:subastapp/network/store_api.dart';

final _storage = new FlutterSecureStorage();
final _storeApi = new StoreApi();
class StorePage extends StatelessWidget {
  const StorePage({Key key}) : super(key: key);

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
            },
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder(
          future: _getStore(),
          builder: (BuildContext context, AsyncSnapshot store) {
            if (store.hasData) {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      height: MediaQuery.of(context).size.width / 1.5,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 3,
                            color: Colors.black,
                          )),
                      child: Image(
                        image: (store.data.imageUrl != null)
                            ? NetworkImage(store.data.imageUrl)
                            : AssetImage('assets/store.png'),
                      ),
                    ),
                    Container(
                      child: Text(
                        (store.data.name != null) ? store.data.name : "Store",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize:
                              Theme.of(context).textTheme.display1.fontSize,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      margin: EdgeInsets.only(bottom: 10.0),
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

Future<Store> _getStore() async {
  print(await _storage.readAll());
  var id = await _storage.read(key: 'store');
  return await _storeApi.getById(id);
}