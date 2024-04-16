
import 'package:projeto/models/pet.dart';
import 'package:projeto/models/user.dart';
import 'package:projeto/repositories/user_repository.dart';

class Sighted {
  String id;
  String color;
  PetType type;
  String? breed;
  String? description;
  String address;
  String city;
  User user;

  Sighted({
    required this.id,
    required this.color,
    required this.type,
    required this.address,
    required this.city,
    this.description,
    this.breed,
    required this.user,
    });
}
