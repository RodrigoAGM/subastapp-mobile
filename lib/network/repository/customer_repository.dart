
import 'dart:convert';
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
}