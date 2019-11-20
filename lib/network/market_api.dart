
import 'package:subastapp/model/market.dart';
import 'package:subastapp/network/repository/market_repository.dart';

class MarketApi{

  final _productRepository = new MarketRepository();

  Future<List<Market>> getAll(){
    return _productRepository.getAll();
  }
}