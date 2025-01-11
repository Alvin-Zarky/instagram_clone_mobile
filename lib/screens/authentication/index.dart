import "package:flutter/material.dart";
import 'package:instagram/screens/authentication/sign_in.dart';
import 'package:instagram/screens/authentication/sign_up.dart';

class IndexAuthScreen extends StatefulWidget {
  const IndexAuthScreen({Key? key}) : super(key: key);

  @override
  State<IndexAuthScreen> createState() => _IndexAuthScreenState();
}

class _IndexAuthScreenState extends State<IndexAuthScreen> {
  bool isSignUp = false;
  void toggleForm() {
    setState(() {
      isSignUp = !isSignUp;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isSignUp) {
      return SignUpScreen(toggle: toggleForm);
    } else {
      return SignInScreen(toggle: toggleForm);
    }
  }
}
