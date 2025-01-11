class ClassModel {
  final String id;
  final String name;
  final bool isLogIn;

  ClassModel({required this.id, required this.name, required this.isLogIn});

  void userGetProfile() {}
}

abstract class UserAbstract {}

mixin ClassMixin {
  void getData() {}
}
