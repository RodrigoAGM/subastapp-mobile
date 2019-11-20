class Market {
  String id;
  String name;
  String address;
  String imageUrl;
  String opensat;
  String closesat;

  Market({this.id, this.name, this.address, this.imageUrl, this.opensat, this.closesat});

  factory Market.fromJson(Map<String, dynamic> json){
    return Market(
        id: json['_id'],
        name: json['name'],
        address: json['adress'],
        imageUrl: json['image_url'],
        opensat: json['opensat'],
        closesat: json['closesat'],
    );
  }

  Map<String, dynamic> toJson() =>{
    '_id'  : id,
    'name'  : name,
    'addess'  : address,
    'image_url'  : imageUrl,
    'opensat'  : opensat,
    'closesat'  : closesat,
  };
}