import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:projeto/models/sighted.dart';
import 'package:projeto/databases/db_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto/services/auth.service.dart';

class SightedRepository extends ChangeNotifier {
  final List<Sighted> _sighteds = [];
  late FirebaseFirestore db;
  late AuthService authService;
  bool isLoading = false;

  UnmodifiableListView<Sighted> get allSightings =>
      UnmodifiableListView(_sighteds);

  SightedRepository({
    required this.authService,
  }) {
    _startRepository();
  }

  _startRepository() async {
    await _startFirestore();
    await _readAllSightings();
  }

  _startFirestore() async {
    db = DBFirestore.get();
  }

  _readAllSightings() async {
    try {
      isLoading = true;
      notifyListeners();
      final querySnapshot = await db.collection('sighted').get();
      for (final doc in querySnapshot.docs) {
        final data = doc.data();
        final sighted = Sighted.fromMap(data);
        _sighteds.add(sighted);
      }
    } catch (e) {
      print('Error reading all sightings: $e');
    }
    isLoading = false;
    notifyListeners();
  }

  addSighting(Sighted sighted) async {
    try {
      isLoading = true;
      notifyListeners();
      _sighteds.add(sighted);
      await db.collection('sighted').doc(sighted.id).set(sighted.toMap());
    } catch (e) {
      print('Error adding sighting: $e');
    }
    isLoading = false;
    notifyListeners();
  }

  filteredSightings(String searchText, String selectedSearchItem) {
    if (searchText.isEmpty) {
      return _sighteds;
    }

    return _sighteds.where((sighting) {
      switch (selectedSearchItem) {
        case 'Cor':
          return sighting.color.toLowerCase().contains(searchText);
        case 'Raça':
          return sighting.breed?.toLowerCase().contains(searchText) ?? false;
        case 'Descrição':
          return sighting.description?.toLowerCase().contains(searchText) ??
              false;
        case 'Endereço':
          return sighting.address.toLowerCase().contains(searchText);
        case 'Cidade':
          return sighting.city.toLowerCase().contains(searchText);
        default:
          return false;
      }
    }).toList();
  }

  Sighted? getSightingById(String id) {
    try {
      return _sighteds.firstWhere((element) => element.id == id);
    } catch (e) {
      return null;
    }
  }

  deleteSighting(String id) async {
    try {
      isLoading = true;
      notifyListeners();
      await db.collection('sighted').doc(id).delete();
      _sighteds.removeWhere((s) => s.id == id);
    } catch (e) {
      print('Error deleting sighting: $e');
    }
    isLoading = false;
    notifyListeners();
  }

  void updateSighting(Sighted sighted) {
    var index = _sighteds.indexWhere((s) => s.id == sighted.id);
    _sighteds[index] = sighted;
    notifyListeners();
  }
}
