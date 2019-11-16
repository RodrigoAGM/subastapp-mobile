class Customer {
  String id;
  String name;
  String email;
  String password;
  String phone;
  int age;
  String image;
  String token;

  Customer({this.id, this.name, this.email, this.password, this.phone, this.age, this.image, this.token});

  factory Customer.fromJson(Map<String, dynamic> json){
    return Customer(
      id : json['_id'],
      name: json['full_name'],
      email: json['email'],
      password: json['password'],
      phone: json['phone'],
      age: json['age'],
      image: json['image']
    );
  }

  Map<String, dynamic> toJson() =>{
    '_id': id,
    'full_name': name,
    'email': email,
    'password':password,
    'phone': phone,
    'age': age,
    'image': image
  };

  Map<String, dynamic> toRegisterJson() =>{
    'full_name': name,
    'email': email,
    'password':password,
  };

   Map<String, dynamic> toLoginJson() =>{
    'email': email,
    'password':password,
  };
}