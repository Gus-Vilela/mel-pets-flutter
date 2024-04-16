import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:projeto/models/user.dart';

class UserRepository extends ChangeNotifier {
  final List<User> _users = [];

  UnmodifiableListView<User> get users => UnmodifiableListView(_users);

  UserRepository() {
    _users.addAll([
      User(
          id: '1000',
          name: 'Gustavo',
          email: 'gustavo@gmail.com',
          phone: '999999999',
          address: 'Rua 1',
          city: 'Ponta Grossa',
          image: 'images/shrek.jpg'),
      User(
        id: '1001',
        name: 'João',
        email: 'jao@gmail.com',
        phone: '999999999',
        address: 'Rua 2',
        city: 'Ponta Grossa',
      )
    ]);
  }

  List<User> getUsers() {
    return _users;
  }

  addUser(User user) {
    _users.add(user);
    notifyListeners();
  }

  removeUser(User user) {
    _users.remove(user);
    notifyListeners();
  }

  updateUser(User user) {
    final index = _users.indexWhere((u) => u.email == user.email);
    if (index >= 0) {
      _users[index] = user;
      notifyListeners();
    }
  }
}

class CurrentUser extends ChangeNotifier {
  static User? currentUser = UserRepository().users[0];
}
