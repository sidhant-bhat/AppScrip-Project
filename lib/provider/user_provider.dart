import 'package:flutter/material.dart';
import 'package:flutter_application_1/api/api.dart';
import 'package:flutter_application_1/model/model.dart';

class UserProvider with ChangeNotifier {
  List<User> _users = [];
  List<User> _filteredUsers = [];
  bool _isLoading = true;
  String _searchString = "";

  List<User> get users => _filteredUsers;
  bool get isLoading => _isLoading;

  final ApiCalls _apiCalls = ApiCalls();

  UserProvider() {
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    _isLoading = true;
    notifyListeners();

    try {
      _users = await _apiCalls.getUsers();
      _applyFilter();
    } catch (e) {
      _users = [];
      _filteredUsers = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _applyFilter() {
    if (_searchString.isNotEmpty) {
      _filteredUsers = _users
          .where((user) =>
              user.name!.toLowerCase().contains(_searchString.toLowerCase()))
          .toList();
    } else {
      _filteredUsers = List.from(_users);
    }
  }

  void setSearchString(String search) {
    _searchString = search;
    _applyFilter();
    notifyListeners();
  }

  void clearSearch() {
    _searchString = "";
    _applyFilter();
    notifyListeners();
  }
}
