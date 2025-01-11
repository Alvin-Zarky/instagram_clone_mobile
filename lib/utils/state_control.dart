import 'dart:async';

import 'package:instagram/utils/state_abstract_class.dart';

class StateControl implements StateAbstractControl {
  final StreamController streamController;

  StateControl() : streamController = StreamController();

  @override
  void notifyListeners() {
    streamController.add('change');
  }

  @override
  void init() {}

  @override
  void dispose() {
    streamController.close();
  }
}
