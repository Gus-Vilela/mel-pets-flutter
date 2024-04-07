import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:projeto/models/pet.dart';
import 'package:projeto/repositories/user_repository.dart';

class PetRepository extends ChangeNotifier {
  List<Pet> pets = [];
  final UserRepository userReposistory = UserRepository();

  UnmodifiableListView<Pet> get allPets => UnmodifiableListView(pets);

  PetRepository() {
    pets.addAll([
      Pet(
        name: 'Rex',
        type: PetType.dog,
        breed: 'Golden Retriever',
        dateOfBirth: DateTime(2018, 5, 20),
        color: 'Golden',
        image: 'images/pets/golden.png',
        status: Status.lost,
        owner: userReposistory.users[0],
      ),
      Pet(
        name: 'Tina',
        type: PetType.cat,
        breed: 'Siamese',
        dateOfBirth: DateTime(2019, 2, 10),
        color: 'White',
        image: 'images/pets/catinho.jpg',
        status: Status.lost,
        owner: userReposistory.users[1],
      ),
      Pet(
        name: 'DefftonesSwabbers',
        type: PetType.dog,
        breed: 'Pitbull',
        dateOfBirth: DateTime(2017, 10, 10),
        color: 'Black',
        image: 'assets/images/dog2.png',
        status: Status.found,
      )
    ]);
  }

  addPet(Pet pet) {
    pets.add(pet);
    notifyListeners();
  }

  Pet getPetByName(String name) {
    return pets.firstWhere((pet) => pet.name == name);
  }

  updatePet(Pet pet) {
    var index = pets.indexWhere((p) => p.name == pet.name);
    if (index != -1) {
      pets[index] = pet;
      notifyListeners();
    }
  }

  deletePet(Pet pet) {
    pets.removeWhere((p) => p.name == pet.name);
    notifyListeners();
  }
}
