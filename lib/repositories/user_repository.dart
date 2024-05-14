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

  UnmodifiableListView<User> get users => UnmodifiableListView(_users);
  User? get currentUser => _currentUser;

  UserRepository({required this.authService}) {
    _startRepository();
  }

  _startRepository() async {
    await _startFirestore();
    await _readCurrentUser();
    await _readAllUsers();
  }

  _startFirestore() async {
    db = DBFirestore.get();
  }

  List<User> getUsers() {
    return _users;
  }

  _readCurrentUser() async {
    if (authService.user != null && _currentUser == null) {
      try {
        final doc =
            await db.collection('users').doc(authService.user!.uid).get();
        if (doc.exists) {
          final data = doc.data();
          _currentUser = User.fromMap(data!);
          notifyListeners();
        }
      } catch (e) {
        print('Erro ao ler usuário atual: $e');
      }
    }
  }

  _readAllUsers() async {
    try {
      final querySnapshot = await db.collection('users').get();
      for (final doc in querySnapshot.docs) {
        final data = doc.data();
        final user = User.fromMap(data);
        _users.add(user);
      }
      notifyListeners();
    } catch (e) {
      print('Erro ao ler usuários: $e');
    }
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

  updateUser(User user) {
    final index = _users.indexWhere((u) => u.email == user.email);
    if (index >= 0) {
      _users[index] = user;
      notifyListeners();
    }
  }
}
