import 'package:projeto/models/pet.dart';

class Sighted {
  String id;
  DateTime? dateOfSight;
  String color;
  PetType type;
  String? breed;
  String? description;
  String address;
  String city;
  String? userId;

  Sighted({
    required this.id,
    required this.dateOfSight,
    required this.color,
    required this.type,
    required this.address,
    required this.city,
    this.description,
    this.breed,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dateOfSight': dateOfSight?.millisecondsSinceEpoch,
      'color': color,
      'type': type.index,
      'address': address,
      'city': city,
      'description': description,
      'breed': breed,
      'userId': userId
    };
  }

  factory Sighted.fromMap(Map<String, dynamic> map) {
    return Sighted(
      id: map['id'] as String,
      dateOfSight: map['dateOfSight'] == null
        ? null
      : DateTime.fromMillisecondsSinceEpoch(map['dateOfSight'] as int),
      color: map['color'] as String,
      type: PetType.values[map['type'] as int],
      address: map['address'] as String,
      city: map['city'] as String,
      description: map['description'] as String?,
      breed: map['breed'] as String?,
      userId: map['userId'] as String?,
    );
  }
}
