import 'package:subastapp/model/product.dart';
import 'package:subastapp/network/repository/product_repository.dart';

class ProductApi{

  final _productRepository = new ProductRepository();

  Future<List<Product>> getAll(){
    return _productRepository.getAll();
  }

  Future<List<Product>> getAllByCategory(String id){
    return _productRepository.getAllByCategory(id);
  }
}