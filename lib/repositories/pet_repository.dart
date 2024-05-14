import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto/databases/db_firestore.dart';
import 'package:projeto/models/pet.dart';
import 'package:projeto/services/auth.service.dart';

class PetRepository extends ChangeNotifier {
  final List<Pet> _pets = [];
  late FirebaseFirestore db;
  late AuthService authService;
  // final UserRepository userReposistory = UserRepository();

  UnmodifiableListView<Pet> get allPets => UnmodifiableListView(_pets);

  PetRepository({
    required this.authService,
  }) {
    _startRepository();
  }

  _startRepository() async {
    await _startFirestore();
    await _readAllPets();
  }

  _startFirestore() async {
    db = DBFirestore.get();
  }

  // PetRepository() {
  //   pets.addAll([
  //     Pet(
  //         id: '1001',
  //         name: 'Rex',
  //         type: PetType.cachorro,
  //         breed: 'Golden Retriever',
  //         dateOfBirth: DateTime(2018, 5, 20),
  //         color: 'Dourada',
  //         image: 'images/pets/Golden.jpg',
  //         status: Status.lost,
  //         owner: CurrentUser.currentUser),
  //     Pet(
  //         id: '1002',
  //         name: 'Tina',
  //         type: PetType.gato,
  //         breed: 'Siamesa',
  //         dateOfBirth: DateTime(2019, 2, 10),
  //         color: 'White',
  //         image: 'images/pets/catinho.jpg',
  //         status: Status.lost,
  //         owner: CurrentUser.currentUser),
  //     Pet(
  //       id: '1003',
  //       name: 'DefftonesSwabbers',
  //       type: PetType.cachorro,
  //       breed: 'Pitbull',
  //       dateOfBirth: DateTime(2017, 10, 10),
  //       color: 'Black',
  //       status: Status.found,
  //     )
  //   ]);
  // }
  _readAllPets() async {
    try {
      final querySnapshot = await db.collection('pets').get();
      for (final doc in querySnapshot.docs) {
        final data = doc.data();
        final pet = Pet.fromMap(data);
        _pets.add(pet);
      }
      notifyListeners();
    } catch (e) {
      print('Error reading pets: $e');
    }
  }

  addPet(Pet pet) async {
    try {
      _pets.add(pet);
      await db.collection('pets').doc(pet.id).set(pet.toMap());
      notifyListeners();
    } catch (e) {
      print('Error adding pet: $e');
    }
  }

  Pet getPetById(String id) {
    return _pets.firstWhere((p) => p.id == id);
  }

  updatePet(Pet pet) {
    var index = _pets.indexWhere((p) => p.id == pet.id);
    _pets[index] = pet;
    notifyListeners();
  }

  deletePet(Pet pet) {
    _pets.removeWhere((p) => p.name == pet.name);
    notifyListeners();
  }

  petFound(Pet pet) {
    var index = _pets.indexWhere((p) => p.id == pet.id);
    _pets[index].status = Status.found;
    notifyListeners();
  }
}
