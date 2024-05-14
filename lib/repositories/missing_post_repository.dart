import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:projeto/models/missing_post.dart';
import 'package:projeto/models/pet.dart';
import 'package:projeto/repositories/user_repository.dart';
import 'package:projeto/repositories/pet_repository.dart';

class MissingPostRepository extends ChangeNotifier {
  List<MissingPost> missingPosts = [];
  // final UserRepository userRepository = UserRepository();

  UnmodifiableListView<MissingPost> get allMissingPosts =>
      UnmodifiableListView(missingPosts);

  MissingPostRepository() {
    missingPosts.addAll([
      MissingPost(
          id: '1000',
          location: 'Proximo ao centro',
          description: 'Cachorro perdido',
          date: DateTime(2024, 1, 12),
          pet: Pet(
            id: '1001',
            name: 'Rex',
            type: PetType.cachorro,
            breed: 'Golden Retriever',
            dateOfBirth: DateTime(2018, 5, 20),
            color: 'Dourada',
            image: 'images/pets/Golden.jpg',
            status: Status.lost,
          ),
          user: CurrentUser.currentUser),
      MissingPost(
        id: '1001',
        location: 'Proximo ao Shopping',
        description: 'Gato perdido',
        date: DateTime(2023, 10, 23),
        pet: Pet(
          id: '1001',
          name: 'Rex',
          type: PetType.cachorro,
          breed: 'Golden Retriever',
          dateOfBirth: DateTime(2018, 5, 20),
          color: 'Dourada',
          image: 'images/pets/Golden.jpg',
          status: Status.lost,
        ),
        user: CurrentUser.currentUser,
      ),
    ]);
  }

  addMissingPost(MissingPost missingPost) {
    missingPosts.add(missingPost);
    notifyListeners();
  }

  removeMissingPost(MissingPost missingPost) {
    missingPosts.remove(missingPost);
    notifyListeners();
  }

  updateMissingPost(MissingPost missingPost) {
    var index =
        missingPosts.indexWhere((element) => element.id == missingPost.id);
    missingPosts[index] = missingPost;
    notifyListeners();
  }
}
