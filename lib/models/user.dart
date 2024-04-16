class User {
  String id;
  String name;
  String email;
  String? phone;
  String? image;
  String? address;
  String? city;
  User({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.image,
    this.address,
    this.city,
  });
}
