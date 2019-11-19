import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:subastapp/model/product.dart';

class ProductRepository{

  Future<List<Product>> getAll(){

    final url = 'https://subastapp.herokuapp.com/products/';
    return http.get(url).then((http.Response response){

      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400) {
        throw new Exception("Error while fetching data");
      }
      Iterable res = json.decode(response.body);
      List<Product> list = res.map((i) => Product.fromJson(i)).toList();
      return list;
    });

  }

   Future<List<Product>> getAllByCategory(String category){

    final url = 'https://subastapp.herokuapp.com/products/byCategory/' + category;
    return http.get(url).then((http.Response response){

      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400) {
        throw new Exception("Error while fetching data");
      }
      Iterable res = json.decode(response.body);
      List<Product> list = res.map((i) => Product.fromJson(i)).toList();
      return list;
    });

  }
}