import 'package:projeto/models/pet.dart';
import 'package:projeto/models/user.dart';

class MissingPost {
  String? location;
  String? description;
  DateTime date;
  Pet pet;
  User owner;

  MissingPost(
      {this.location,
      this.description,
      required this.date,
      required this.pet,
      required this.owner});

  void update(MissingPost post) {
    location = post.location;
    description = post.description;
    date = post.date;
    pet = post.pet;
    owner = post.owner;
  }
}
