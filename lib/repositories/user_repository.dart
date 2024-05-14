import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto/databases/db_firestore.dart';
import 'package:projeto/models/user.dart';
import 'package:projeto/services/auth.service.dart';

class UserRepository extends ChangeNotifier {
  final List<User> _users = [];
  User? _currentUser;
  late FirebaseFirestore db;
  late AuthService authService;
  bool isLoading = false;

  UnmodifiableListView<User> get users => UnmodifiableListView(_users);
  User? get currentUser => _currentUser;

  UserRepository({required this.authService}) {
    _startRepository();
  }

  _startRepository() async {
    await _startFirestore();
    await _readAllUsers();
    _currentUser = getUserById(authService.user!.uid);
  }

  _startFirestore() async {
    db = DBFirestore.get();
  }

  List<User> getUsers() {
    return _users;
  }

  _readAllUsers() async {
    try {
      isLoading = true;
      notifyListeners();
      final querySnapshot = await db.collection('users').get();
      for (final doc in querySnapshot.docs) {
        final data = doc.data();
        final user = User.fromMap(data);
        _users.add(user);
      }
    } catch (e) {
      print('Erro ao ler usuários: $e');
    }
    isLoading = false;
    notifyListeners();
  }

  addUser(User user) async {
    try {
      _users.add(user);
      await db.collection('users').doc(authService.user!.uid).set(user.toMap());
    } catch (e) {
      print('Erro ao adicionar usuário: $e');
    }
    notifyListeners();
  }

  getUserById(String id) {
    return _users.firstWhere((u) => u.id == id);
  }

  updateUser(User user) async {
    try {
      var index = _users.indexWhere((u) => u.id == user.id);
      _users[index] = user;
      await db.collection('users').doc(user.id).update(user.toMap());
    } catch (e) {
      print('Erro ao atualizar usuário: $e');
    }
    notifyListeners();
  }
}
