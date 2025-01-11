import "package:flutter/material.dart";
import 'package:instagram/models/user_model.dart';
import 'package:instagram/providers/user_provider.dart';
import 'package:instagram/screens/authentication/index.dart';
import 'package:instagram/screens/home/index.dart';
import 'package:instagram/services/user_service.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    UserService().getUserInfo(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<UserProvider>(context).user;
    return user!.token.isNotEmpty
        ? const IndexScreen()
        : const IndexAuthScreen();
  }
}
