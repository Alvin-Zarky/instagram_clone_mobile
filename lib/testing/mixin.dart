import 'package:flutter/material.dart';

abstract class ClassInterface {
  void init();
  void dispose();
}

class Animal {
  void move() => debugPrint("can move");
}

class Car extends ClassInterface {
  @override
  void dispose() {}

  @override
  void init() {}
}

class Value extends Car implements Animal {
  @override
  void move() {}
}

class Dog implements Animal {
  @override
  void move() {}
}

class Cat extends Animal {
  @override
  void move() {
    super.move();
    debugPrint('can moew');
  }
}

mixin CanSwim {
  void swim() {
    debugPrint('can swim');
  }
}

mixin CanFly {
  void fly() {
    debugPrint('can fly');
  }
}

class Duck extends Animal with CanSwim, CanFly {
  @override
  void move() {
    super.move();
    debugPrint('move');
  }

  @override
  void swim() {
    super.swim();
    debugPrint('swim');
  }

  @override
  void fly() {
    super.fly();
    debugPrint('fly');
  }

  // void nani() {
  //   print('nani');
  // }
}

class Dick with CanSwim, CanFly {
  // void nani() {
  //   print('nani');
  // }
  @override
  void swim() {
    super.swim();
    debugPrint('swim');
  }

  @override
  void fly() {
    super.fly();
    debugPrint('fly');
  }
}

class Main {
  final duck = Duck().swim();

  final dick = Dick().fly();
}
