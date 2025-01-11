import 'package:flutter/material.dart';

class PageProvider extends ChangeNotifier {
  int _currentPage = 0;
  int get currentPage => _currentPage;

  void onTapNavigate(int index) {
    _currentPage = index;
    notifyListeners();
  }
}
