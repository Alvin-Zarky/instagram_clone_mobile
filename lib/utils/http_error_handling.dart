import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:instagram/utils/snackbar_modal.dart';

class HttpErrorHandling {
  void handleErrorHandling({
    required BuildContext context,
    required http.Response response,
    required VoidCallback onSuccess,
  }) {
    switch (response.statusCode) {
      case 200:
      case 201:
        onSuccess();
        break;
      case 400:
      case 401:
      case 404:
      case 500:
        ModalSnackBar().showSnackBarModal(
            context: context, message: jsonDecode(response.body)['message']);
        break;
      default:
        ModalSnackBar()
            .showSnackBarModal(context: context, message: response.body);
    }
  }
}
