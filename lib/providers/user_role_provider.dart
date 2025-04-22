import 'package:flutter/material.dart';

class UserRoleProvider with ChangeNotifier {
  String _role = 'user';

  String get role => _role;

  set role(String newRole) {
    _role = newRole;
    notifyListeners();
  }
}