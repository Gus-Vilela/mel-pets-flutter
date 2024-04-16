import 'package:projeto/models/user.dart';

enum PetType {
  cachorro,
  gato,
  passaro,
  peixe,
  coelho,
  hamster,
  tartaruga,
  porquinhoDaIndia,
  outros
}

enum Status { lost, found }

class Pet {
  String id;
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
      {required this.id,
      this.name,
      required this.type,
      this.breed,
      this.color,
      this.dateOfBirth,
      this.image,
      this.owner,
      required this.status});
}
