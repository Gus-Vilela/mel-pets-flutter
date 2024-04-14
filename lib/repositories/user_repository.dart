import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:projeto/models/user.dart';

class UserRepository extends ChangeNotifier {
  final List<User> _users = [];

  UnmodifiableListView<User> get users => UnmodifiableListView(_users);

  UserRepository() {
    _users.addAll([
      User(
        name: 'Tatiane',
        email: 'tatiane@gmail.com',
        phone: '999999999',
        address: 'Rua 1',
        city: 'Ponta Grossa',
        image: 'assets/images/user1.png',
      ),
      User(
        name: 'João',
        email: 'jao@gmail.com',
        phone: '999999999',
        address: 'Rua 2',
        city: 'Ponta Grossa',
        image: 'assets/images/user2.png',
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
  final User? _user;

  CurrentUser(this._user);

  User? get user => _user;

  static User? currentUser = UserRepository().users[0];
}
