import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto/databases/db_firestore.dart';
import 'package:projeto/models/missing_post.dart';

class MissingPostRepository extends ChangeNotifier {
  final List<MissingPost> _missingPosts = [];
  late FirebaseFirestore db;
  bool isLoading = false;

  UnmodifiableListView<MissingPost> get allMissingPosts =>
      UnmodifiableListView(_missingPosts);

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
      isLoading = true;
      notifyListeners();
      final querySnapshot = await db.collection('missing_posts').get();
      for (final doc in querySnapshot.docs) {
        final data = doc.data();
        final missingPost = MissingPost.fromMap(data);
        _missingPosts.add(missingPost);
      }
    } catch (e) {
      print('Erro ao ler os dados: $e');
    }
    isLoading = false;
    notifyListeners();
  }

  addMissingPost(MissingPost missingPost) async {
    try {
      isLoading = true;
      notifyListeners();
      await db
          .collection('missing_posts')
          .doc(missingPost.id)
          .set(missingPost.toMap());
      _missingPosts.add(missingPost);
    } catch (e) {
      print('Erro ao adicionar post: $e');
    }
    isLoading = false;
    notifyListeners();
  }

  removeMissingPost(MissingPost missingPost) async {
    try {
      isLoading = true;
      notifyListeners();
      await db.collection('missing_posts').doc(missingPost.id).delete();
      _missingPosts.remove(missingPost);
    } catch (e) {
      print('Erro ao remover post: $e');
    }
    isLoading = false;
    notifyListeners();
  }

  MissingPost? getMissingPostById(String id) {
    try {
      return _missingPosts.firstWhere((element) => element.id == id);
    } catch (e) {
      return null;
    }
  }

  updateMissingPost(MissingPost missingPost) async {
    try {
      isLoading = true;
      notifyListeners();
      var index = _missingPosts.indexWhere((p) => p.id == missingPost.id);
      _missingPosts[index] = missingPost;
      await db
          .collection('missing_posts')
          .doc(missingPost.id)
          .update(missingPost.toMap());
    } catch (e) {
      print('Erro ao atualizar post: $e');
    }
    isLoading = false;
    notifyListeners();
  }
}
