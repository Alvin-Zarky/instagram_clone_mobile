import 'dart:convert';

class Chat {
  int? id;
  String? message;
  int? userId;
  UserType? user;

  Chat({
    this.id,
    this.message,
    this.userId,
    this.user,
  });

  Chat copyWith({
    int? id,
    String? message,
    int? userId,
    UserType? user,
  }) {
    return Chat(
      id: id ?? this.id,
      message: message ?? this.message,
      userId: userId ?? this.userId,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'message': message,
      'userId': userId,
      'user': user?.toMap(),
    };
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      id: map['id'] != null ? map['id'] as int : null,
      message: map['message'] != null ? map['message'] as String : null,
      userId: map['userId'] != null ? map['userId'] as int : null,
      user: map['user'] != null
          ? UserType.fromMap(map['user'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Chat.fromJson(String source) =>
      Chat.fromMap(json.decode(source) as Map<String, dynamic>);
}

class UserType {
  final int id;
  final String name;
  final String email;
  final String photo;

  UserType({
    required this.id,
    required this.name,
    required this.email,
    required this.photo,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'photo': photo,
    };
  }

  factory UserType.fromMap(Map<String, dynamic> map) {
    return UserType(
      id: map['id'] as int,
      name: map['name'] as String,
      email: map['email'] as String,
      photo: map['photo'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserType.fromJson(String source) =>
      UserType.fromMap(json.decode(source) as Map<String, dynamic>);
}
