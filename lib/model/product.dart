class Product {
  String id;
  String name;
  String description;
  String imageUrl;
  int stock;
  num price;
  int discontinued;
  String categoryId;
  String storeId;

  Product({this.id, this.name, this.description, this.imageUrl, this.stock, this.price, this.discontinued, this.categoryId, this.storeId});

  factory Product.fromJson(Map<String, dynamic> json){
    return Product(
      id : json['_id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['image_url'],
      stock: json['stock'],
      price: json['unit_price'],
      discontinued: json['discontinued'],
      categoryId: json['category'],
      storeId: json['store'],
    );
  }

  Map<String, dynamic> toJson() =>{
    '_id': id,
    'name': name,
    'description': description,
    'image_url': imageUrl,
    'stock': stock,
    'unit_price': price,
    'discontinued': discontinued,
    'category': categoryId,
    'store': storeId,
  };
}