import 'package:flutter/material.dart';
import 'package:instagram/models/post_models.dart';

class GetSinglePost extends ChangeNotifier {
  PostModel _post = PostModel();
  PostModel get post => _post;

  void postById(PostModel data) {
    _post = data;
    notifyListeners();
  }
}
