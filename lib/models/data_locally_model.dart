import 'dart:convert';

class DataLocally {
  int? id;
  String? title;
  String? content;

  DataLocally({this.id, this.title, this.content});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'content': content,
    };
  }

  factory DataLocally.fromMap(Map<String, dynamic> map) {
    return DataLocally(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      content: map['content'] != null ? map['content'] as String : null,
    );
  }

  factory DataLocally.fromSnap(dynamic data) {
    return DataLocally(
      id: data['id'] ?? 0,
      title: data['title'] ?? '',
      content: data['content'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DataLocally.fromJson(String source) =>
      DataLocally.fromMap(json.decode(source) as Map<String, dynamic>);
}
