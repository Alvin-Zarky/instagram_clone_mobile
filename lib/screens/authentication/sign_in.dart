import "package:flutter/material.dart";
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:instagram/routes/route_path.dart';
import 'package:instagram/services/user_service.dart';

class SignInScreen extends StatefulWidget {
  final VoidCallback toggle;
  const SignInScreen({Key? key, required this.toggle}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _globalKey = GlobalKey<FormState>();
  final _textNameController = TextEditingController();
  final _textPasswordController = TextEditingController();
  final UserService userService = UserService();

  String textName = '';
  String password = '';
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _textNameController.clear();
    _textPasswordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 35, right: 35),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 150, bottom: 40),
                  child: const Image(
                    image: AssetImage("lib/assets/icon/Instagram_logo.png"),
                    height: 75,
                    fit: BoxFit.contain,
                  ),
                ),
                Form(
                  key: _globalKey,
                  child: _formController(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _formController() {
    return Column(
      children: [
        TextFormField(
          autocorrect: false,
          enableSuggestions: false,
          controller: _textNameController,
          decoration: const InputDecoration(
            hintText: 'Please input email or username',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.all(19),
          ),
          onChanged: (value) => setState(() => textName = value),
          validator: ((value) {
            if (value!.isEmpty) {
              return "Enter email or username";
            }
            return null;
          }),
        ),
        const SizedBox(height: 25),
        TextFormField(
          enableSuggestions: false,
          autocorrect: false,
          controller: _textPasswordController,
          obscureText: true,
          decoration: const InputDecoration(
            hintText: 'Password',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.all(19),
          ),
          onChanged: (value) => setState(() => password = value),
          validator: (value) => value!.isEmpty ? "Enter password" : null,
        ),
        GestureDetector(
          onTap: () async {
            if (_globalKey.currentState!.validate()) {
              setState(() => isLoading = true);
              await userService.userLogIn(
                  context: context, textName: textName, password: password);
              setState(() => isLoading = false);
            }
          },
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 25),
            padding: const EdgeInsets.all(19),
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(5)),
            child: Text(
              isLoading ? "Loggin in..." : "Log In",
              style: const TextStyle(
                  color: Colors.white, fontSize: 16, fontFamily: "Inter"),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 50, bottom: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Don't have an account?",
                style: TextStyle(fontFamily: "Inter"),
              ),
              const SizedBox(width: 5),
              GestureDetector(
                  onTap: widget.toggle,
                  child: const Text("Sign Up.",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontFamily: "Inter")))
            ],
          ),
        )
      ],
    );
  }
}
