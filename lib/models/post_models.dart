import 'dart:convert';

class PostModel {
  List<Likes>? likes;
  List<Comments>? comments;
  int? id;
  String? text;
  List<String>? media;
  List<String>? tags;
  String? createdAt;
  String? updatedAt;
  int? userId;
  Likes? user;

  PostModel({
    this.likes,
    this.comments,
    this.id,
    this.text,
    this.media,
    this.tags,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.user,
  });

  PostModel.fromMap(Map<String, dynamic> json) {
    if (json['likes'] != null) {
      likes = <Likes>[];
      json['likes'].forEach((v) {
        likes!.add(Likes.fromJson(v));
      });
    }
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(Comments.fromJson(v));
      });
    }
    id = json['id'];
    text = json['text'];
    media = json['media'].cast<String>();
    tags = json['tags'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    userId = json['userId'];
    user = json['user'] != null ? Likes.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (likes != null) {
      data['likes'] = likes!.map((v) => v.toJson()).toList();
    }
    if (comments != null) {
      data['comments'] = comments!.map((v) => v.toJson()).toList();
    }
    data['id'] = id;
    data['text'] = text;
    data['media'] = media;
    data['tags'] = tags;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['userId'] = userId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }

  String toJson() => json.encode(toMap());
  factory PostModel.fromJson(String source) =>
      PostModel.fromMap(json.decode(source));
}

class Likes {
  int? id;
  String? name;
  String? email;
  String? photo;

  Likes({this.id, this.name, this.email, this.photo});

  Likes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    photo = json["photo"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['photo'] = photo;
    return data;
  }
}

class Comments {
  int? id;
  String? name;
  String? email;
  String? photo;
  String? comment;
  dynamic createdAt;

  Comments(
      {this.id,
      this.name,
      this.email,
      this.photo,
      this.comment,
      this.createdAt});

  Comments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    photo = json['photo'];
    comment = json['comment'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['photo'] = photo;
    data['comment'] = comment;
    data['createdAt'] = createdAt;
    return data;
  }
}
