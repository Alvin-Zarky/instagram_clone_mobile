import 'package:flutter/material.dart';
import 'package:instagram/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  List<User> _allUser = [];
  User? _user = User(
    id: 0,
    name: '',
    email: '',
    user: '',
    password: '',
    role: '',
    isAdmin: false,
    isActive: true,
    photo: '',
    createdAt: '',
    token: '',
  );

  List<User> get allUser => _allUser;
  User? get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  void setUserModel(User user) {
    _user = user;
    notifyListeners();
  }

  void updateUser({
    String? name,
    String? email,
    String? bio,
    String? links,
    String? photo,
  }) {
    user!.name = name!;
    user!.email = email!;
    user!.bio = bio;
    user!.links = links;
    user!.photo = photo;
    notifyListeners();
  }

  void getAllUser(List<User> data) {
    _allUser = data;
    notifyListeners();
  }

  void insertUser(User user) {
    _allUser.insert(0, user);
    notifyListeners();
  }
}
