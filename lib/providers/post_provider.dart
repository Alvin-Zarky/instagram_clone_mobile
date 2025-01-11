import 'package:flutter/material.dart';
import 'package:instagram/models/post_models.dart';

class PostProvider extends ChangeNotifier {
  List<PostModel> _post = [];

  List<PostModel> get post => _post;
  int get length => _post.length;

  void getAllPost(List<PostModel> post) {
    _post = post;
    notifyListeners();
  }

  void insertPost(PostModel post) {
    _post.insert(0, post);
    notifyListeners();
  }

  void editPost({
    required int id,
    String? text,
    List<String>? media,
    List<Comments>? comments,
    List<Likes>? likes,
    List<String>? tags,
  }) {
    _post[id].text = text;
    _post[id].comments = comments;
    _post[id].media = media;
    _post[id].likes = likes;
    _post[id].tags = tags;
    notifyListeners();
  }

  void deletePost({required PostModel post}) {
    _post.remove(post);
    notifyListeners();
  }

  void removePost({required int index}) {
    _post.removeAt(index);
    notifyListeners();
  }
}
