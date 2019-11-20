import 'package:subastapp/model/store.dart';
import 'package:subastapp/network/repository/store_repository.dart';

class StoreApi{

  StoreRepository _storeRepository = new StoreRepository();

  Future<List<Store>> getAll(){
    return _storeRepository.getAll();
  }

  Future<Store> getById(String id){
    return _storeRepository.getById(id);
  }

  Future<String> register(String name, String description, String storeNumber, String phone, String opens, String closes, String marketId, String contactName){
    return _storeRepository.register( name,  description,  storeNumber,  phone,  opens,  closes, marketId, contactName);
  }
}
