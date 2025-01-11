import 'package:flutter/material.dart';

class ModalSnackBar {
  void showSnackBarModal({
    required BuildContext context,
    required String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color.fromARGB(255, 188, 44, 33),
        content: Text(
          message,
          style: const TextStyle(color: Colors.white, fontFamily: "Inter"),
        ),
      ),
    );
  }
}
