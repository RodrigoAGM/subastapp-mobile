import 'package:subastapp/model/product.dart';
import 'package:subastapp/network/repository/product_repository.dart';

class ProductApi{
  final _productRepository= new ProductRepository();

  Future<List<Product>> getAll() async{
    return await _productRepository.getAll();
  }
}