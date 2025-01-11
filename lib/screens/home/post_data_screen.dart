import 'dart:io';
import 'package:flutter/material.dart';
import 'package:instagram/screens/page/preview_image.dart';
import 'package:instagram/utils/image_picker.dart';

class PostDataScreen extends StatefulWidget {
  const PostDataScreen({Key? key}) : super(key: key);

  @override
  State<PostDataScreen> createState() => _PostDataScreenState();
}

class _PostDataScreenState extends State<PostDataScreen> {
  final ImagePicker imagePicker = ImagePicker();
  List<File> images = [];

  void setReferenceImages() async {
    final res = await imagePicker.pickMultiImages(context: context);
    if (res.isNotEmpty) {
      setState(() => images = res);
      // ignore: use_build_context_synchronously
      Navigator.of(context).push(MaterialPageRoute(
          builder: ((context) => ImagePreviewing(images: images))));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: const Image(
                height: 80,
                fit: BoxFit.cover,
                image: AssetImage("lib/assets/img/photo-and-video.png"),
              ),
            ),
            const SizedBox(height: 25),
            const SizedBox(
              child: Text(
                "Choose photos and videos here",
                style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            GestureDetector(
              onTap: setReferenceImages,
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 12, bottom: 12),
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(5)),
                child: const Text(
                  "Upload here",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Inter",
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
