// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:instagram/utils/snackbar_modal.dart';

class ImagePicker {
  Future pickSingleImage({required BuildContext context}) async {
    File? path;
    try {
      final FilePickerResult? file =
          await FilePicker.platform.pickFiles(type: FileType.image);

      if (file != null && file.files.isNotEmpty) {
        path = File(file.files[0].path!);
      }
    } catch (err) {
      ModalSnackBar()
          .showSnackBarModal(context: context, message: err.toString());
    }

    return path;
  }

  Future<List<File>> pickMultiImages({required BuildContext context}) async {
    List<File> images = [];
    try {
      final FilePickerResult? files = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true,
      );

      if (files != null && files.files.isNotEmpty) {
        for (int i = 0; i < files.files.length; i++) {
          images.add(File(files.files[i].path!));
        }
      }
    } catch (err) {
      ModalSnackBar()
          .showSnackBarModal(context: context, message: err.toString());
    }
    return images;
  }
}
