import 'package:flutter/material.dart';
import 'package:subastapp/model/category.dart';
import 'package:subastapp/network/category_api.dart';
import 'package:subastapp/ui/products/products_screen.dart';

class HomePage extends StatelessWidget {
  final CategoryApi _categoryApi = new CategoryApi();

  Future<List<Mcategory>> function() async {
    var list = await _categoryApi.getAll();
    return list;
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
          IconButton(
            icon: Icon(Icons.search, color: Theme.of(context).accentColor,),
            onPressed: () {
              findProduct(context);
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: FutureBuilder<List<Mcategory>>(
              future: function(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return ListBody(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ProductPage(snapshot.data[index].id)),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.all(20.0),
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      snapshot.data[index].name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  ClipRRect(
                                    borderRadius: new BorderRadius.only(
                                        bottomRight: Radius.circular(20.0),
                                        bottomLeft: Radius.circular(20.0)),
                                    child: Image(
                                      image: AssetImage(
                                          "assets/image/category.jpg"),
                                    ),
                                  )
                                ],
                              ),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                  shape: BoxShape.rectangle,
                                  color: Colors.white,
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color: Colors.black38,
                                        blurRadius: 5.0,
                                        offset: Offset(1.0, 6.0)),
                                  ]),
                            ),
                          )
                        ],
                      );
                    },
                  );
                } else {
                  return Center(child: RefreshProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

findProduct(BuildContext context) {
  TextEditingController customController = TextEditingController();

  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("¿Qué deseas buscar?"),
          content: TextField(
            controller: customController,
          ),
          actions: <Widget>[
            MaterialButton(
              elevation: 5.0,
              child: Text("Buscar"),
              onPressed: () {
                Navigator.of(context).pop(customController.text.toString());
              },
            )
          ],
        );
      });
}
