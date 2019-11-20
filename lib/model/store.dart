class Store {
  String id;
  String name;
  String description;
  String storeNumber;
  num floor;
  String contactName;
  String email;
  String webpage;
  num phone;
  String imageUrl;
  String opensat;
  String closesat;

  Store({this.id, this.name, this.description, this.storeNumber, this.floor, this.contactName, this.email,
  this.webpage, this.phone, this.imageUrl, this.opensat, this.closesat});

  factory Store.fromJson(Map<String, dynamic> json){
    return Store(
        id: json['_id'],
        name: json['name'],
        description: json['description'],
        storeNumber: json['store_number'],
        floor:json['floor'],
        contactName:json['contact_name'],
        email: json['email'],
        webpage: json['webpage'],
        phone: json['phone'],
        imageUrl: json['image_url'],
        opensat: json['opensat'],
        closesat: json['closesat'],
    );
  }

  Map<String, dynamic> toJson() =>{
    '_id'  : id,
    'name'  : name,
    'description'  : description,
    'store_number'  : storeNumber,
    'floor'  : floor,
    'contact_name'  : contactName,
    'email'  : email,
    'webpage'  : webpage,
    'phone'  : phone,
    'image_url'  : imageUrl,
    'opensat'  : opensat,
    'closesat'  : closesat,
  };
}