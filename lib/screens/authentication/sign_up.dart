import 'package:email_validator/email_validator.dart';
import "package:flutter/material.dart";
import 'package:instagram/constants/constant.dart';
import 'package:instagram/services/user_service.dart';

class SignUpScreen extends StatefulWidget {
  final VoidCallback toggle;
  const SignUpScreen({Key? key, required this.toggle}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _globalKey = GlobalKey<FormState>();
  final UserService userService = UserService();

  final _textUserName = TextEditingController();
  final _textEmail = TextEditingController();
  final _textPassword = TextEditingController();
  final _textConfirmPassword = TextEditingController();

  String name = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _textUserName.clear();
    _textEmail.clear();
    _textPassword.clear();
    _textConfirmPassword.clear();
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
                  margin: const EdgeInsets.only(top: 100, bottom: 10),
                  child: const Image(
                    image: AssetImage("lib/assets/icon/Instagram_logo.png"),
                    height: 75,
                    fit: BoxFit.contain,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 30),
                  padding: const EdgeInsets.only(left: 35, right: 35),
                  child: const Text(
                    "Sign up to see photos and videos from your friends",
                    style: kTextDescriptionAuth,
                    textAlign: TextAlign.center,
                  ),
                ),
                Form(
                  key: _globalKey,
                  child: Column(
                    children: [
                      TextFormField(
                        enableSuggestions: false,
                        autocorrect: false,
                        controller: _textUserName,
                        decoration: const InputDecoration(
                          hintText: 'Username',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(19),
                        ),
                        onChanged: (value) => setState(() => name = value),
                        validator: ((value) {
                          if (value!.isEmpty) {
                            return "Enter username";
                          }
                          return null;
                        }),
                      ),
                      const SizedBox(height: 25),
                      TextFormField(
                        enableSuggestions: false,
                        autocorrect: false,
                        controller: _textEmail,
                        decoration: const InputDecoration(
                          hintText: 'Email',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(19),
                        ),
                        onChanged: (value) => setState(() => email = value),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter email";
                          }
                          if (!EmailValidator.validate(email)) {
                            return "Email invalid";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 25),
                      TextFormField(
                        controller: _textPassword,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: 'Password',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(19),
                        ),
                        onChanged: (value) => setState(() => password = value),
                        validator: (value) =>
                            value!.isEmpty ? "Enter password" : null,
                      ),
                      const SizedBox(height: 25),
                      TextFormField(
                          controller: _textConfirmPassword,
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintText: 'Confirm Password',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.all(19),
                          ),
                          onChanged: (value) =>
                              setState(() => confirmPassword = value),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter confirm password";
                            }
                            if (confirmPassword != password) {
                              return "Confirm password does not matched";
                            }
                            return null;
                          }),
                      GestureDetector(
                        onTap: () async {
                          if (_globalKey.currentState!.validate()) {
                            setState(() => isLoading = true);
                            await userService.userSignUp(
                              context: context,
                              name: name,
                              email: email,
                              password: password,
                            );
                            setState(() => isLoading = false);
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 25),
                          padding: const EdgeInsets.all(19),
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            isLoading ? "Loggin in..." : "Log In",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: "Inter"),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 30, bottom: 30),
                        padding: const EdgeInsets.only(left: 35, right: 35),
                        child: const Text(
                          "By Signing up, you agree to our Terms, Data Policy and Cookie Policy.",
                          style: kTextDescriptionAuth,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 30, bottom: 100),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already have an account?",
                              style: TextStyle(fontFamily: "Inter"),
                            ),
                            const SizedBox(width: 5),
                            GestureDetector(
                                onTap: widget.toggle,
                                child: const Text("Log In.",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue,
                                        fontFamily: "Inter")))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
