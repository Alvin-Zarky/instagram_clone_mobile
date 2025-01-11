import 'package:flutter/material.dart';
import 'package:instagram/models/chat_model.dart';

class ChatProvider extends ChangeNotifier {
  List<Chat> _chat = [];
  List<Chat> get chat => _chat;
  int get length => _chat.length;

  void sendChat(Chat data) {
    _chat.insert(0, data);
    notifyListeners();
  }

  void getUserChat(List<Chat> data) {
    _chat = data;
    notifyListeners();
  }

  void updateUserChat({required int index, required String message}) {
    _chat[index].message = message;
    notifyListeners();
  }

  void removeUserChat({required Chat data}) {
    _chat.remove(data);
    notifyListeners();
  }

  void removeIndexUserChat(int index) {
    _chat.removeAt(index);
    notifyListeners();
  }
}
