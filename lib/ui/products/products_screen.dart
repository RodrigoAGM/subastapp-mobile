import 'package:flutter/material.dart';
import 'package:subastapp/model/product.dart';
import 'package:subastapp/network/product_api.dart';

class ProductPage extends StatefulWidget {
  final categoryId;

  ProductPage(this.categoryId);

  @override
  _ProductPageState createState() => _ProductPageState(categoryId);
}

class _ProductPageState extends State<ProductPage> {
  final _categoryId;

  _ProductPageState(this._categoryId);

  @override
  Widget build(BuildContext context) {
    final api = ProductApi();
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
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).accentColor,
          ),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        child: FutureBuilder(
          future: api.getAllByCategory(_categoryId),
          builder:
              (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
            if (snapshot.hasData && snapshot.data.length > 0) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                      ),                       
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: Container(
                              height: 100,
                              width: 100,
                              child: Image.network(snapshot.data[index].imageUrl),
                            ),
                            title: Text(
                              snapshot.data[index].name,
                            ),
                            subtitle: Text(
                              'S/. ${snapshot.data[index].price.toString()}',
                            ),
                            onTap: () {
                              receiveOffers(context);
                            },
                          )),
                    ),
                  );
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

List<Widget> _buildGridTiles(int numberOfTiles, List<Product> products) {
  List<Stack> containers = List<Stack>.generate(numberOfTiles, (int index) {
    return Stack(
      alignment: const Alignment(1.0, 1.0),
      children: <Widget>[
        GestureDetector(
            child: Container(
              child: Image.network(products[index].imageUrl,
                  width: 150.0, height: 150.0, fit: BoxFit.fill),
            ),
            onTap: () {}),
      ],
    );
  });
  return containers;
}

receiveOffers(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("¿Deseas recibir ofertas de las tiendas cercanas?"),
          actions: <Widget>[
            MaterialButton(
              elevation: 5.0,
              child: Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      });
}
