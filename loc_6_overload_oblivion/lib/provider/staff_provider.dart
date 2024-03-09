import 'package:flutter/material.dart';
import 'package:loc_6_overload_oblivion/models/staff_model.dart';
import 'package:loc_6_overload_oblivion/resources/auth_methods.dart';
import 'package:provider/provider.dart';

class StaffProvider with ChangeNotifier {
  Staff? _user;
  final AuthMethods _authMethods = AuthMethods();

  Staff getUser() {
    return _user!;
  }

  Future<void> refreshUser() async {
    Staff user = await _authMethods.getStaffDetails();
    _user = user;
    print(_user!.staffid);
    notifyListeners();
  }
}
