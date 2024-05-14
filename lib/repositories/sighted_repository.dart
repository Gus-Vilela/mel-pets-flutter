import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:projeto/models/pet.dart';
import 'package:projeto/models/sighted.dart';
import 'package:projeto/models/user.dart';
import 'package:projeto/repositories/user_repository.dart';
import 'package:projeto/databases/db_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto/services/auth.service.dart';


class SightedRepository extends ChangeNotifier {
  final List<Sighted> _sighteds = [];
  late FirebaseFirestore db;
  late AuthService authService;

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
    try{
      final querySnapshot = await db.collection('sightings').get();
      for(final doc in querySnapshot.docs){
        final data = doc.data();
        final sighted = Sighted.fromMap(data);
        _sighteds.add(sighted);
      }
      notifyListeners();
    } catch (e) {
      print('Error reading all sightings: $e');
    }
    }
  

  addSighting(Sighted sighted) async {
    try{
      _sighteds.add(sighted);
      await db.collection('sighted').doc(sighted.id).set(sighted.toMap());
      notifyListeners();
    }catch(e){
      print('Error adding sighting: $e');
    }
    
  }

  Sighted getSightingById(String id) {
    return _sighteds.firstWhere((s) => s.id == id);
  }

  void updateSighting(Sighted sighted) {
    var index = _sighteds.indexWhere((s) => s.id == sighted.id);
    _sighteds[index] = sighted;
    notifyListeners();
  }

  void deleteSighting(String id) {
    _sighteds.removeWhere((sighting) => sighting.id == id);
    notifyListeners();
  }
}
