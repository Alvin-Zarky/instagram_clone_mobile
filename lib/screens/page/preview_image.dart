// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import "package:flutter/material.dart";
import 'package:instagram/constants/constant.dart';
import 'package:instagram/models/user_model.dart';
import 'package:instagram/providers/user_provider.dart';
import 'package:instagram/routes/route_path.dart';
import 'package:instagram/services/post_service.dart';
import 'package:provider/provider.dart';

class ImagePreviewing extends StatefulWidget {
  final List<File> images;
  const ImagePreviewing({
    Key? key,
    required this.images,
  }) : super(key: key);

  @override
  State<ImagePreviewing> createState() => _ImagePreviewingState();
}

class _ImagePreviewingState extends State<ImagePreviewing> {
  final _formKey = GlobalKey<FormState>();
  final _textCaption = TextEditingController();

  final PostService postService = PostService();
  String caption = '';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: isLoading
                                ? () {}
                                : () {
                                    Navigator.of(context).pop();
                                  },
                            child: const Icon(
                              Icons.chevron_left,
                              size: 27,
                            ),
                          ),
                          GestureDetector(
                            onTap: isLoading
                                ? () {}
                                : () async {
                                    setState(() => isLoading = true);
                                    await postService.postData(
                                      context: context,
                                      media: widget.images,
                                      text: _textCaption.text,
                                      userId: user!.id,
                                    );
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                            Routes.defaultScreen,
                                            (route) => false);
                                    setState(() => isLoading = false);
                                  },
                            child: isLoading
                                ? const CircularProgressIndicator()
                                : const Text(
                                    "Share",
                                    style: kTextEditProfile,
                                  ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: CarouselSlider(
                        options: CarouselOptions(height: 500),
                        items: widget.images.map((val) {
                          return Builder(builder: ((context) {
                            return Container(
                              margin:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: Image(
                                width: MediaQuery.of(context).size.width,
                                height: 500,
                                fit: BoxFit.fitWidth,
                                image: AssetImage(val.path),
                              ),
                            );
                          }));
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 25),
                padding: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 15, right: 15),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Color.fromARGB(255, 207, 207, 207),
                    ),
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    autocorrect: false,
                    enableSuggestions: false,
                    controller: _textCaption,
                    keyboardType: TextInputType.multiline,
                    minLines: 3,
                    maxLines: 5,
                    onChanged: (value) => setState(() => caption = value),
                    validator: (value) => value!.isEmpty ? "Enter caption" : "",
                    decoration: const InputDecoration(
                      hintText: 'Write a caption...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.only(
                      top: 20, bottom: 20, left: 15, right: 15),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Color.fromARGB(255, 207, 207, 207),
                      ),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Add Location",
                        style: TextStyle(fontFamily: "Inter", fontSize: 15),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.only(
                      top: 20, bottom: 20, left: 15, right: 15),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Color.fromARGB(255, 207, 207, 207),
                      ),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Advanced Settings",
                        style: TextStyle(fontFamily: "Inter", fontSize: 15),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                      ),
                    ],
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
