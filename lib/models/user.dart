class User {
  String id;
  String name;
  String email;
  String? phone;
  String? address;
  String? city;
  String? image;
  User({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.image,
    this.address,
    this.city,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'image': image,
      'address': address,
      'city': city,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String?,
      image: map['image'] as String?,
      address: map['address'] as String?,
      city: map['city'] as String?,
    );
  }
}
