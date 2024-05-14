import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto/databases/db_firestore.dart';
import 'package:projeto/models/missing_post.dart';

class MissingPostRepository extends ChangeNotifier {
  List<MissingPost> missingPosts = [];
  late FirebaseFirestore db;
  // final UserRepository userRepository = UserRepository();

  UnmodifiableListView<MissingPost> get allMissingPosts =>
      UnmodifiableListView(missingPosts);

  MissingPostRepository() {
    _startRepository();
  }

  _startRepository() async {
    await _startFirestore();
    await _readAllMissingPosts();
  }

  _startFirestore() async {
    db = DBFirestore.get();
  }

  // MissingPostRepository() {
  //   missingPosts.addAll([
  //     MissingPost(
  //         id: '1000',
  //         location: 'Proximo ao centro',
  //         description: 'Cachorro perdido',
  //         date: DateTime(2024, 1, 12),
  //         pet: Pet(
  //           id: '1001',
  //           name: 'Rex',
  //           type: PetType.cachorro,
  //           breed: 'Golden Retriever',
  //           dateOfBirth: DateTime(2018, 5, 20),
  //           color: 'Dourada',
  //           image: 'images/pets/Golden.jpg',
  //           status: Status.lost,
  //         ),
  //         user: CurrentUser.currentUser),
  //     MissingPost(
  //       id: '1001',
  //       location: 'Proximo ao Shopping',
  //       description: 'Gato perdido',
  //       date: DateTime(2023, 10, 23),
  //       pet: Pet(
  //         id: '1001',
  //         name: 'Rex',
  //         type: PetType.cachorro,
  //         breed: 'Golden Retriever',
  //         dateOfBirth: DateTime(2018, 5, 20),
  //         color: 'Dourada',
  //         image: 'images/pets/Golden.jpg',
  //         status: Status.lost,
  //       ),
  //       user: CurrentUser.currentUser,
  //     ),
  //   ]);
  // }

  _readAllMissingPosts() async {
    try {
      final querySnapshot = await db.collection('missing_posts').get();
      for (final doc in querySnapshot.docs) {
        final data = doc.data();
        final missingPost = MissingPost.fromMap(data);
        missingPosts.add(missingPost);
      }
      notifyListeners();
    } catch (e) {
      print('Erro ao ler os dados: $e');
    }
  }

  addMissingPost(MissingPost missingPost) {
    try {
      db
          .collection('missing_posts')
          .doc(missingPost.id)
          .set(missingPost.toMap());
      missingPosts.add(missingPost);
      notifyListeners();
    } catch (e) {
      print('Erro ao adicionar post: $e');
    }
  }

  removeMissingPost(MissingPost missingPost) {
    missingPosts.remove(missingPost);
    notifyListeners();
  }

  getMissingPostById(String id) {
    return missingPosts.firstWhere((element) => element.id == id);
  }

  updateMissingPost(MissingPost missingPost) {
    var index =
        missingPosts.indexWhere((element) => element.id == missingPost.id);
    missingPosts[index] = missingPost;
    notifyListeners();
  }
}
