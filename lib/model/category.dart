import 'package:subastapp/model/product.dart';

class Mcategory {
  String id;
  String name;
  String description;
  String imageUrl;
  List<Product> products;

  Mcategory({this.id, this.name, this.description, this.imageUrl});

  factory Mcategory.fromJson(Map<String, dynamic> json){
    return Mcategory(
      id : json['_id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() =>{
    '_id': id,
    'name': name,
    'description': description,
    'image_url': imageUrl,
  };
}