import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto/databases/db_firestore.dart';
import 'package:projeto/models/missing_post.dart';

class MissingPostRepository extends ChangeNotifier {
  List<MissingPost> missingPosts = [];
  late FirebaseFirestore db;

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
