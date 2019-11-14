
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:subastapp/model/customer.dart';
import 'package:http/http.dart' as http;

class CustomerRepository{

  Future<String> register(String name, String email, String password){


    Customer cus = new Customer(id: null, age: null, email: email, name: name, password: password, image: null, phone: null);

    final url = 'https://subastapp.herokuapp.com/customers/signup';
    return http.post(url,body: cus.toRegisterJson()).then((http.Response response){

      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400) {
        throw new Exception("Error while fetching data");
      }
      var res = json.decode(response.body);
      var message = res['message'];

      return message;
    });
  }

  Future<Customer> login(String email, String password){

    Customer cus = new Customer(id: null, age: null, email: email, name: null, password: password, image: null, phone: null);

    final url = 'https://subastapp.herokuapp.com/customers/signin';
    return http.post(url,body: cus.toLoginJson()).then((http.Response response){
      final int statusCode = response.statusCode;
      var newId = "";
      var newEmail = "";

      if (statusCode < 200 || statusCode > 401) {
        throw new Exception("Error while fetching data");
      }
      else if (statusCode == 401){
        newId = "not found";
        newEmail = "not found";
      }
      else{
        var res = json.decode(response.body);
        var token = res['token'];

        var parsedData = parseJwt(token);
        
        newId = parsedData['userId'];
        newEmail = parsedData['email'];
      }
      
      Customer newCus = new Customer(id: newId, age: null, email: newEmail, name: null, password: cus.password, image: null, phone: null);
      return newCus;
    });
  }
}

Map<String, dynamic> parseJwt(String token) {
  final parts = token.split('.');
  if (parts.length != 3) {
    throw Exception('invalid token');
  }

  final payload = _decodeBase64(parts[1]);
  final payloadMap = json.decode(payload);
  
  if (payloadMap is! Map<String, dynamic>) {
    throw Exception('invalid payload');
  }

  return payloadMap;
}

String _decodeBase64(String str) {
  
  String output = str.replaceAll('-', '+').replaceAll('_', '/');

  switch (output.length % 4) {
    case 0:
      break;
    case 2:
      output += '==';
      break;
    case 3:
      output += '=';
      break;
    default:
      throw Exception('Illegal base64url string!"');
  }

  return utf8.decode(base64Url.decode(output));
}