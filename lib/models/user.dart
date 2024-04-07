class User {
  String name;
  String email;
  String? phone;
  String? image;
  String? address;
  String? city;
  User({
    required this.name,
    required this.email,
    this.phone,
    this.image,
    this.address,
    this.city,
  });

  void update(User user) {
    name = user.name;
    email = user.email;
    phone = user.phone;
    image = user.image;
    address = user.address;
    city = user.city;
  }
}
