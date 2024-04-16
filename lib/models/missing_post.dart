import 'package:projeto/models/pet.dart';
import 'package:projeto/models/user.dart';

class MissingPost {
  String id;
  String location;
  String description;
  DateTime date;
  Pet pet;
  User user;

  MissingPost(
      {required this.id,
      required this.location,
      required this.description,
      required this.date,
      required this.pet,
      required this.user});
}
