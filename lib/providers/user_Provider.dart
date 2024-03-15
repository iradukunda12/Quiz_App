import 'package:flutter/material.dart';

import '../models/User.dart';

class Users extends ChangeNotifier {
  User _user = User(studentId: '', email: '', token: '', password: '');

  User get user => _user;

  void setUser(User user) {
    _user = User.fromJson(user as String);
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}
