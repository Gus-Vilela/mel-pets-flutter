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
        id: '1001',
        name: 'Rex',
        type: PetType.cachorro,
        breed: 'Golden Retriever',
        dateOfBirth: DateTime(2018, 5, 20),
        color: 'Dourada',
        image: 'images/pets/Golden.jpg',
        status: Status.lost,
        owner: userReposistory.users[0],
      ),
      Pet(
        id: '1002',
        name: 'Tina',
        type: PetType.gato,
        breed: 'Siamesa',
        dateOfBirth: DateTime(2019, 2, 10),
        color: 'White',
        image: 'images/pets/catinho.jpg',
        status: Status.lost,
        owner: userReposistory.users[1],
      ),
      Pet(
        id: '1003',
        name: 'DefftonesSwabbers',
        type: PetType.cachorro,
        breed: 'Pitbull',
        dateOfBirth: DateTime(2017, 10, 10),
        color: 'Black',
        status: Status.found,
      )
    ]);
  }

  addPet(Pet pet) {
    pets.add(pet);
    notifyListeners();
  }

  Pet getPetById(String id) {
    return pets.firstWhere((p) => p.id == id);
  }

  updatePet(Pet pet) {
    var index = pets.indexWhere((p) => p.id == pet.id);
    pets[index] = pet;
    notifyListeners();
  }

  deletePet(Pet pet) {
    pets.removeWhere((p) => p.name == pet.name);
    notifyListeners();
  }

  petFound(Pet pet) {
    var index = pets.indexWhere((p) => p.id == pet.id);
    pets[index].status = Status.found;
    notifyListeners();
  }
}
