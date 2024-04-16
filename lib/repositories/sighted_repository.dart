import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:projeto/models/pet.dart';
import 'package:projeto/models/sighted.dart';
import 'package:projeto/models/user.dart';
import 'package:projeto/repositories/user_repository.dart';


class SightedRepository extends ChangeNotifier {
  List<Sighted> sightings = [];

  UnmodifiableListView<Sighted> get allSightings => UnmodifiableListView(sightings);
  SightedRepository() {
    sightings.addAll([
      Sighted(
        id:'1',
        color: 'Preto',
        type: PetType.dog,
        breed: 'Pitbull',
        description: 'Gordo',
        address: 'UEPG',
        city:'Ponta Grossa',
        user: CurrentUser.currentUser
      ),
      Sighted(
        id:'2',
        color: 'Laranja',
        type: PetType.cat,
        breed: 'Viralata',
        description: 'dois olhos',
        address: 'UTFPR',
        city:'Ponta Grossa',
        user: CurrentUser.currentUser
      ),
    ]);
  }

  
  void addSighting(Sighted sighting) {
    sightings.add(sighting);
    notifyListeners();
  }

 
  void updateSighting(int index, Sighted updatedSighting) {
    if (index >= 0 && index < sightings.length) {
      sightings[index] = updatedSighting;
      notifyListeners();
    }
  }

 

  void deleteSighting(String id) {
    
    sightings.removeWhere((sighting) => sighting.id == id);
    notifyListeners();

    }
}
