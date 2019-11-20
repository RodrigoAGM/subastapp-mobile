class Store {
  String id;
  String name;
  String marketId;
  String description;
  String storeNumber;
  num floor;
  String contactName;
  String email;
  String webpage;
  String phone;
  String imageUrl;
  String opensat;
  String closesat;

  Store({this.id, this.name, this.description, this.storeNumber, this.floor, this.contactName, this.email,
  this.webpage, this.phone, this.imageUrl, this.opensat, this.closesat, this.marketId});

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
        marketId: json['market'],
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
    'market': marketId,
  };

  Map<String, dynamic> toRegisterJson() =>{
    'name'  : name,
    'description'  : description,
    'contact_name' : contactName,
    'email' :email,
    'phone': phone,
    'store_number'  : storeNumber,
    'opensat'  : opensat,
    'closesat'  : closesat,
    'market':marketId,
  };
}