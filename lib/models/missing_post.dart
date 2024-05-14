import 'package:projeto/models/pet.dart';
import 'package:projeto/models/user.dart';

class MissingPost {
  String id;
  String location;
  String description;
  DateTime date;
  String petId;
  String userId;

  MissingPost(
      {required this.id,
      required this.location,
      required this.description,
      required this.date,
      required this.petId,
      required this.userId});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'location': location,
      'description': description,
      'date': date,
      'petId': petId,
      'userId': userId,
    };
  }

  factory MissingPost.fromMap(Map<String, dynamic> map) {
    return MissingPost(
      id: map['id'] as String,
      location: map['location'] as String,
      description: map['description'] as String,
      date: map['date'].toDate() as DateTime,
      petId: map['petId'] as String,
      userId: map['userId'] as String,
    );
  }
}
