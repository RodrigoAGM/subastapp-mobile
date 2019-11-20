import 'package:subastapp/model/customer.dart';
import 'package:subastapp/network/repository/customer_repository.dart';

class CustomerApi{

  final _customerRepository = new CustomerRepository();

  Future<String> register(String name, String email, String password){
    return _customerRepository.register(name, email, password);
  }

  Future<Customer> login(String email, String password){
    return _customerRepository.login(email, password);
  }

  Future<bool> editCustomerStore(String storeId){
    return _customerRepository.editCustomerStore(storeId);
  }
}