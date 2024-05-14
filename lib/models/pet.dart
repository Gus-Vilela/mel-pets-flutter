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
  String? userId;

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
      this.userId,
      required this.status});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type.index,
      'breed': breed,
      'dateOfBirth': dateOfBirth?.millisecondsSinceEpoch,
      'color': color,
      'image': image,
      'status': status.index,
      'userId': userId,
    };
  }

  factory Pet.fromMap(Map<String, dynamic> map) {
    return Pet(
      id: map['id'] as String,
      name: map['name'] as String?,
      type: PetType.values[map['type'] as int],
      breed: map['breed'] as String?,
      dateOfBirth: map['dateOfBirth'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(map['dateOfBirth'] as int),
      color: map['color'] as String?,
      image: map['image'] as String?,
      status: Status.values[map['status'] as int],
      userId: map['userId'] as String?,
    );
  }
}
