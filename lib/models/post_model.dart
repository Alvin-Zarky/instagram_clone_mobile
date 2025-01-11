import 'dart:convert';
import 'package:instagram/models/user_model.dart';

class Post {
  final String id;
  final int userId;
  String? text;
  List<String>? media;
  List<User>? likes;
  List<User>? comments;
  List<String>? tags;
  dynamic createdAt;

  Post({
    required this.id,
    required this.userId,
    this.text,
    this.media,
    this.likes,
    this.comments,
    this.tags,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "userId": userId,
      "text": text,
      "media": media,
      "likes": likes,
      "comments": comments,
      "tags": tags,
      "createdAt": createdAt,
    };
  }

  factory Post.fromMap(Map<String, dynamic> data) {
    return Post(
      id: data["id"] ?? 0,
      userId: data["userId"] ?? 0,
      text: data["text"] ?? '',
      media: data["media"] ?? [],
      likes: data["likes"] ?? [],
      comments: data["comments"] ?? [],
      tags: data["tags"] ?? [],
      createdAt: data["createdAt"] ?? '',
    );
  }

  String toJson() => json.encode(toMap());
  factory Post.fromJson(String source) => Post.fromMap(json.decode(source));
}
