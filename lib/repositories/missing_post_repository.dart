import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:projeto/models/missing_post.dart';

//import user repository
import 'package:projeto/repositories/user_repository.dart';
import 'package:projeto/repositories/pet_repository.dart';

class MissingPostRepository extends ChangeNotifier {
  List<MissingPost> missingPosts = [];
  final UserRepository userRepository = UserRepository();
  final PetRepository petRepository = PetRepository();

  UnmodifiableListView<MissingPost> get allMissingPosts =>
      UnmodifiableListView(missingPosts);

  MissingPostRepository() {
    missingPosts.addAll([
      MissingPost(
        location: 'Rua 1',
        description: 'Cachorro perdido',
        date: DateTime(2024, 1, 12),
        pet: petRepository.pets[0],
        user: userRepository.users[0],
      ),
      MissingPost(
        location: 'Rua 2',
        description: 'Gato perdido',
        date: DateTime(2023, 10, 23),
        pet: petRepository.pets[1],
        user: userRepository.users[1],
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
    var index = missingPosts
        .indexWhere((p) => p.description == missingPost.description);
    if (index != -1) {
      missingPosts[index] = missingPost;
      notifyListeners();
    }
  }
}
