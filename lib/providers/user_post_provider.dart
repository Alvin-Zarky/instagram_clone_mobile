import "package:flutter/material.dart";
import 'package:instagram/models/post_models.dart';

class UserPostProvider extends ChangeNotifier {
  List<PostModel> _post = [];

  List<PostModel> get post => _post;
  int get length => _post.length;

  void getPostByUser(List<PostModel> data) {
    _post = data;
    notifyListeners();
  }
}
