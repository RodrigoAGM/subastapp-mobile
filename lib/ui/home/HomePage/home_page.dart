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

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
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
                                MaterialPageRoute(builder: (context) => ProductPage()),
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
                                      style: TextStyle(fontWeight: FontWeight.bold, ),
                                    ),
                                  ),
                                  ClipRRect(
                                    borderRadius: new BorderRadius.only(bottomRight: Radius.circular(20.0), bottomLeft: Radius.circular(20.0)),
                                    child: Image(
                                      image: AssetImage("assets/image/category.jpg"),
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
                  //Center(child: Text("Nothing to see"));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}


/*
class DataSearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    //actions for app bar

    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {},
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //leading icon on the left of the app bar

    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {});
  }

  @override
  Widget buildResults(BuildContext context) {
    //show some result base on the selection
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //show when someone searches for something

    final suggestionList = query.isEmpty ? 

    return null;
  }
}

*/