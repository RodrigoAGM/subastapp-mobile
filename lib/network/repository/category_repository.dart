import 'dart:convert';
import 'package:subastapp/model/category.dart';
import 'package:http/http.dart' as http;

class CategoryRepository{

  Future<List<Mcategory>> getAll(){

    final url = 'https://subastapp.herokuapp.com/categories/';
    return http.get(url).then((http.Response response){

      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400) {
        throw new Exception("Error while fetching data");
      }
      Iterable res = json.decode(response.body);
      List<Mcategory> list = res.map((i) => Mcategory.fromJson(i)).toList();
      return list;
    });

  }
}