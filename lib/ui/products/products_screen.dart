import 'package:flutter/material.dart';
import 'package:subastapp/model/product.dart';
import 'package:subastapp/network/product_api.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    final api = ProductApi();
    return Scaffold(
      body: Container(
        child: FutureBuilder(
          future: api.getAll(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: Container(
                              height: 100,
                              width: 100,
                              child:
                                  Image.network(snapshot.data[index].imageUrl),
                            ),
                            title: Text(
                              snapshot.data[index].name,
                            ),
                            subtitle: Text(
                              'S/. ${snapshot.data[index].price.toString()}',
                            ),
                          )),
                    ),
                  );
                },
              );
            }
            return Center(
              child: Text('Cargando...'),
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
