import 'package:flutter/material.dart';
import 'package:subastapp/model/category.dart';
import 'package:subastapp/network/category_api.dart';

class HomePage extends StatelessWidget {

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
                if(snapshot.hasData){
                  return Text(snapshot.data[0].name);
                }else{
                  return Text("Nothing to see");
                }

                return CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
    );
  }
}

CategoryApi _categoryApi = new CategoryApi();

Future<List<Mcategory>> function() async{
    var list = await _categoryApi.getAll();
    return list;
}