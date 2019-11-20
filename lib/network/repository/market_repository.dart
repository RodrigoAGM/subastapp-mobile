import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:subastapp/model/market.dart';
import 'package:http/http.dart' as http;


class MarketRepository{

  Future<List<Market>> getAll(){

    final url = 'https://subastapp.herokuapp.com/market/';
    return http.get(url).then((http.Response response){

      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400) {
        throw new Exception("Error while fetching data");
      }
      Iterable res = json.decode(response.body);
      List<Market> list = res.map((i) => Market.fromJson(i)).toList();
      return list;
    });

  }
}