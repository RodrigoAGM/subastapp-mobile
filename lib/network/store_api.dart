import 'package:subastapp/model/store.dart';
import 'package:subastapp/network/repository/store_repository.dart';

class ProductApi{

  StoreRepository _storeRepository = new StoreRepository();

  Future<List<Store>> getAll(){
    return _storeRepository.getAll();
  }

  Future<Store> getById(String id){
    return _storeRepository.getById(id);
  }
}
