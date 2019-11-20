import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:subastapp/model/store.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:subastapp/network/customer_api.dart';

class StoreRepository {
  final _storage = new FlutterSecureStorage();
  final _customerApi = new CustomerApi();

  Future<List<Store>> getAll() {
    final url = 'https://subastapp.herokuapp.com/stores/';
    return http.get(url).then((http.Response response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400) {
        throw new Exception("Error while fetching data");
      }
      var res = json.decode(response.body);
      List<Store> list = res.map((i) => Store.fromJson(i)).toList();
      return list;
    });
  }

  Future<Store> getById(String id) {
    final url = 'https://subastapp.herokuapp.com/stores/' + id;
    return http.get(url).then((http.Response response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400) {
        throw new Exception("Error while fetching data");
      }
      var res = json.decode(response.body);
      Store store = Store.fromJson(res);
      return store;
    });
  }

  Future<String> register(
      String name,
      String description,
      String storeNumber,
      String phone,
      String opens,
      String closes,
      String marketId,
      String contactName) async {
    var token = await _storage.read(key: 'token');
    var email = await _storage.read(key: 'email');

    Store sto = new Store(
        storeNumber: storeNumber,
        name: name,
        description: description,
        phone: phone,
        opensat: opens,
        closesat: closes,
        marketId: marketId,
        email: email,
        contactName: contactName);

    final url = 'https://subastapp.herokuapp.com/stores/';

    Map<String, String> headers = {"Authorization": token};

    return http
        .post(url, body: sto.toRegisterJson(), headers: headers)
        .then((http.Response response) async {

      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400) {
        throw new Exception("Error while fetching data");
      }

      var res = json.decode(response.body);
      var id = res['_id'];
      await _storage.write(key: 'store', value: id);

      //await _customerApi.editCustomerStore(id.toString());

      return "success";
    });
  }
}
