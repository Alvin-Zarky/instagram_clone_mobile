import 'dart:convert';

class User {
  final int id;
  String name;
  String email;
  final String password;
  final String role;
  final bool isAdmin;
  final bool isActive;
  String? photo;
  final String token;
  dynamic createdAt;
  String? user;
  int? posts;
  int? follower;
  int? following;
  String? bio;
  String? links;
  String? currentPassword;
  String? comment;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.user,
    required this.password,
    required this.role,
    required this.isAdmin,
    required this.isActive,
    required this.photo,
    required this.createdAt,
    this.posts,
    this.follower,
    this.following,
    this.bio,
    this.links,
    required this.token,
    this.currentPassword,
    this.comment,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "user": user,
      "password": password,
      "role": role,
      "isAdmin": isAdmin,
      "isActive": isActive,
      "photo": photo,
      "createdAt": createdAt,
      "posts": posts,
      "follower": follower,
      "following": following,
      "bio": bio,
      "links": links,
      "currentPassword": currentPassword,
      "comment": comment,
    };
  }

  factory User.fromMap(Map<String, dynamic> data) {
    return User(
      id: data["id"] ?? 0,
      name: data["name"] ?? '',
      email: data["email"] ?? '',
      user: data["user"] ?? '',
      password: data["password"] ?? '',
      role: data["role"] ?? 'user',
      isAdmin: data["isAdmin"] ?? false,
      isActive: data["isActive"] ?? false,
      photo: data["photo"] ?? '',
      createdAt: data["createdAt"] ?? '',
      posts: data["posts"] ?? 0,
      follower: data["follower"] ?? 0,
      following: data["following"] ?? 0,
      bio: data["bio"] ?? '',
      links: data["links"] ?? '',
      token: data["token"] ?? '',
      currentPassword: data["currentPassword"] ?? '',
      comment: data["comment"] ?? '',
    );
  }

  String toJson() => json.encode(toMap());
  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
