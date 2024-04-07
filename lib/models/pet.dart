import 'package:projeto/models/user.dart';

enum PetType { dog, cat, bird, fish, rabbit, hamster, turtle, guineaPig, other }

enum Status { lost, found }

class Pet {
  String? name;
  PetType type;
  String? breed;
  DateTime? dateOfBirth;
  String? color;
  String? image;
  Status status;
  User? owner;

  get age {
    if (dateOfBirth == null) return null;
    return DateTime.now().difference(dateOfBirth!).inDays ~/ 365;
  }

  Pet(
      {this.name,
      required this.type,
      this.breed,
      this.dateOfBirth,
      this.color,
      this.image,
      this.owner,
      required this.status});
}
