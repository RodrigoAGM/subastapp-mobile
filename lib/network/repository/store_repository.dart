import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:subastapp/model/store.dart';

class StoreRepository{

  Future<List<Store>> getAll(){

    final url = 'https://subastapp.herokuapp.com/stores/';
    return http.get(url).then((http.Response response){

      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400) {
        throw new Exception("Error while fetching data");
      }
      var res = json.decode(response.body);
      List<Store> list = res.map((i) => Store.fromJson(i)).toList();
      return list;
    });

  }

  Future<Store> getById(String id){

    final url = 'https://subastapp.herokuapp.com/stores/' + id;
    return http.get(url).then((http.Response response){

      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400) {
        throw new Exception("Error while fetching data");
      }
      var res = json.decode(response.body);
      Store store = Store.fromJson(res);
      return store;
    });

  }
}
