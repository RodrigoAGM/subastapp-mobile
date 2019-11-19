import 'package:subastapp/model/category.dart';
import 'package:subastapp/network/repository/category_repository.dart';

class CategoryApi{

  final _categoryRepository = new CategoryRepository();

  Future<List<Mcategory>> getAll(){
    return _categoryRepository.getAll();
  }
}