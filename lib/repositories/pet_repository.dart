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

  deletePet(Pet pet) {
    try {
      db.collection('pets').doc(pet.id).delete();
      _pets.remove(pet);
      notifyListeners();
    } catch (e) {
      print('Error deleting pet: $e');
    }
  }

  updatePet(Pet pet) {
    try {
      var index = _pets.indexWhere((p) => p.id == pet.id);
      _pets[index] = pet;
      db.collection('pets').doc(pet.id).update(pet.toMap());
      notifyListeners();
    } catch (e) {
      print('Error updating pet: $e');
    }
  }

  Pet? getPetById(String id) {
    try {
      return _pets.firstWhere((element) => element.id == id);
    } catch (e) {
      return null;
    }
  }

  petFound(Pet pet) {
    pet.status = Status.found;
    updatePet(pet);
  }
}
