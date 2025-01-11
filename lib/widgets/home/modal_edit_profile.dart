// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:email_validator/email_validator.dart';
import "package:flutter/material.dart";
import 'package:instagram/constants/constant.dart';
import 'package:instagram/models/user_model.dart';
import 'package:instagram/providers/user_provider.dart';
import 'package:instagram/services/user_service.dart';
import 'package:instagram/utils/image_picker.dart';
import 'package:provider/provider.dart';

class ModalEditProfile extends StatefulWidget {
  final User user;
  const ModalEditProfile({Key? key, required this.user}) : super(key: key);

  @override
  State<ModalEditProfile> createState() => _ModalEditProfileState();
}

class _ModalEditProfileState extends State<ModalEditProfile> {
  final UserService userService = UserService();
  final ImagePicker imagePicker = ImagePicker();

  final _globalKey = GlobalKey<FormState>();
  final _textName = TextEditingController();
  final _textEmail = TextEditingController();
  final _textBio = TextEditingController();
  final _textLink = TextEditingController();
  final _textCurrentPassword = TextEditingController();
  final _textPassword = TextEditingController();

  String name = '';
  String email = '';
  String bio = '';
  String links = '';
  String password = '';
  String currentPassword = '';
  // List<File> images = [];
  File? image;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _textName.text = widget.user.name;
    _textEmail.text = widget.user.email;
    _textBio.text = widget.user.bio!;
    _textLink.text = widget.user.links!;
  }

  @override
  void dispose() {
    super.dispose();

    _textName.clear();
    _textEmail.clear();
    _textPassword.clear();
    _textCurrentPassword.clear();
    _textBio.clear();
    _textLink.clear();
  }

  void setUploadImage() async {
    File? res = await imagePicker.pickSingleImage(context: context);
    setState(() => image = res);
  }

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<UserProvider>(context, listen: false).user;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 17, right: 17, top: 60, bottom: 5),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: isLoading
                              ? () {}
                              : () {
                                  Navigator.of(context).pop();
                                  setState(() => image = null);
                                },
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              fontSize: 17,
                              color: isLoading ? Colors.grey : Colors.black,
                              fontFamily: "Inter",
                            ),
                          ),
                        ),
                        const Text(
                          "Edit Profile",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "Roboto",
                            letterSpacing: 0.3,
                            fontSize: 17,
                          ),
                        ),
                        GestureDetector(
                          onTap: isLoading
                              ? () {}
                              : () async {
                                  if (_globalKey.currentState!.validate()) {
                                    setState(() => isLoading = true);
                                    await userService
                                        .userEditProfile(
                                      context: context,
                                      name: name,
                                      email: email,
                                      photo: image?.path ?? '',
                                      bio: _textBio.text,
                                      links: _textLink.text,
                                      password: _textPassword.text,
                                      currentPassword:
                                          _textCurrentPassword.text,
                                    )
                                        .then((value) {
                                      Navigator.of(context).pop();
                                      setState(() => isLoading = false);
                                      setState(() => image = null);
                                    });
                                  }
                                },
                          child: isLoading
                              ? const CircularProgressIndicator()
                              : const Text(
                                  "Done",
                                  style: kTextEditProfile,
                                ),
                        ),
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(top: 35),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: setUploadImage,
                            child: CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.transparent,
                              child: image != null
                                  ? Image.asset(image!.path)
                                  : Image.network(user!.photo!),
                            ),
                          ),
                          const SizedBox(width: 23),
                          GestureDetector(
                            onTap: setUploadImage,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: const CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.transparent,
                                child: Icon(
                                  Icons.face_outlined,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: setUploadImage,
                      child: Container(
                        margin: const EdgeInsets.only(top: 20, bottom: 20),
                        child: Text(
                          "Edit picture or avatar",
                          style: kTextEditProfile.copyWith(fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    border: Border(
                        top: BorderSide(
                  color: Color.fromARGB(255, 212, 212, 212),
                ))),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 17, right: 17, top: 10, bottom: 15),
                  child: Form(
                    key: _globalKey,
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(
                                child: Text(
                                  "Name",
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                flex: 3,
                                child: TextFormField(
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  controller: _textName,
                                  // initialValue: user.name,
                                  onChanged: ((value) {
                                    setState(() => name = value);
                                  }),
                                  validator: ((value) =>
                                      value!.isEmpty ? "Enter name" : null),
                                  decoration: kStyleInputEditProfile.copyWith(
                                      hintText: 'Username'),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(
                                child: Text(
                                  "Email",
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                flex: 3,
                                child: TextFormField(
                                  autocorrect: false,
                                  enableSuggestions: false,
                                  controller: _textEmail,
                                  // initialValue: user.email,
                                  onChanged: (value) =>
                                      setState(() => email = value),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Enter email";
                                    }
                                    if (!EmailValidator.validate(value)) {
                                      return "Email invalid";
                                    }
                                    return null;
                                  },
                                  decoration: kStyleInputEditProfile.copyWith(
                                      hintText: 'Email'),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(
                                child: Text(
                                  "Bio",
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                flex: 3,
                                child: TextFormField(
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  controller: _textBio,
                                  // initialValue: user.bio,
                                  onChanged: (value) =>
                                      setState(() => bio = value),
                                  decoration: kStyleInputEditProfile.copyWith(
                                      hintText: 'Bio'),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(
                                child: Text(
                                  "Links",
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                flex: 3,
                                child: TextFormField(
                                    enableSuggestions: false,
                                    autocorrect: false,
                                    controller: _textLink,
                                    onChanged: (value) =>
                                        setState(() => links = value),
                                    decoration: kStyleInputEditProfile.copyWith(
                                        hintText: 'Add Links')),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(
                                child: Text(
                                  "Password",
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                flex: 3,
                                child: TextFormField(
                                    obscureText: true,
                                    controller: _textCurrentPassword,
                                    onChanged: (value) =>
                                        setState(() => currentPassword = value),
                                    decoration: kStyleInputEditProfile.copyWith(
                                        hintText: 'Current Password')),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(
                                child: Text(
                                  "Password",
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                flex: 3,
                                child: TextFormField(
                                  obscureText: true,
                                  controller: _textPassword,
                                  onChanged: (value) =>
                                      setState(() => password = value),
                                  decoration: kStyleInputEditProfile.copyWith(
                                      hintText: 'Password'),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
