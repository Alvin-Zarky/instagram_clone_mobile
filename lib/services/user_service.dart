// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:instagram/models/user_model.dart';
import 'package:instagram/providers/user_provider.dart';
import 'package:instagram/utils/http_error_handling.dart';
import 'package:instagram/utils/snackbar_modal.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final url = dotenv.get('URI', fallback: '');
final cloudName = dotenv.get('CLOUD_NAME', fallback: '');
final imagePreset = dotenv.get('UPLOAD_PRESET', fallback: '');
// const String url = 'http://localhost:5000/api/instagram/clone';
// const String cloudName = 'dt89p7jda';
// const String imagePreset = 'instagram_presets';

class UserService {
  Future<void> userLogIn({
    required BuildContext context,
    required String textName,
    required String password,
  }) async {
    try {
      final values = User(
        id: 0,
        name: '',
        user: textName,
        email: '',
        password: password,
        role: '',
        isAdmin: false,
        isActive: true,
        photo: '',
        createdAt: '',
        token: '',
      );
      final http.Response res = await http.post(
        Uri.parse("$url/user/login/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
        },
        body: values.toJson(),
      );

      HttpErrorHandling().handleErrorHandling(
        context: context,
        response: res,
        onSuccess: () async {
          Provider.of<UserProvider>(context, listen: false)
              .setUser(jsonEncode(jsonDecode(res.body)['data']));
          final SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          sharedPreferences.setString(
              'token', jsonDecode(res.body)['data']['token']);
        },
      );
    } catch (err) {
      ModalSnackBar()
          .showSnackBarModal(context: context, message: err.toString());
    }
  }

  Future<void> userSignUp({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      final User values = User(
        id: 0,
        name: name,
        email: email,
        user: '',
        password: password,
        role: 'user',
        isAdmin: false,
        isActive: true,
        photo: '',
        createdAt: '',
        token: '',
      );

      http.Response res = await http.post(
        Uri.parse("$url/user/register"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
        },
        body: values.toJson(),
      );

      HttpErrorHandling().handleErrorHandling(
        context: context,
        response: res,
        onSuccess: () async {
          Provider.of<UserProvider>(context, listen: false)
              .setUser(jsonEncode(jsonDecode(res.body)['data']));
          await sharedPreferences.setString(
              'token', jsonDecode(res.body)['data']['token']);
        },
      );
    } catch (err) {
      ModalSnackBar().showSnackBarModal(
        context: context,
        message: err.toString(),
      );
    }
  }

  Future<void> userSignOut({required BuildContext context}) async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final String? token = sharedPreferences.getString('token');

      http.Response res = await http.get(
        Uri.parse("$url/user/logout/"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=utf-8",
          "Authorization": "Bearer $token"
        },
      );

      final User user = User(
        id: 0,
        name: '',
        email: '',
        user: '',
        password: '',
        role: '',
        isAdmin: false,
        isActive: true,
        photo: '',
        createdAt: '',
        token: '',
      );

      HttpErrorHandling().handleErrorHandling(
        context: context,
        response: res,
        onSuccess: () async {
          Provider.of<UserProvider>(context, listen: false)
              .setUser(user.toJson());
          await sharedPreferences.setString('token', '');
        },
      );
    } catch (err) {
      ModalSnackBar()
          .showSnackBarModal(context: context, message: err.toString());
    }
  }

  Future<void> getUserInfo({required BuildContext context}) async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final String? token = sharedPreferences.getString('token');

      if (token == '') {
        await sharedPreferences.setString('token', '');
      } else {
        final http.Response res = await http.get(
          Uri.parse("$url/user/profile/"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8',
            'Authorization': 'Bearer $token',
          },
        );

        HttpErrorHandling().handleErrorHandling(
          context: context,
          response: res,
          onSuccess: () {
            Provider.of<UserProvider>(context, listen: false)
                .setUser(jsonEncode(jsonDecode(res.body)['data']));
          },
        );
      }
    } catch (err) {
      ModalSnackBar()
          .showSnackBarModal(context: context, message: err.toString());
    }
  }

  Future userEditProfile({
    required BuildContext context,
    required String name,
    required String email,
    required String photo,
    required String bio,
    required String links,
    required String password,
    required String currentPassword,
  }) async {
    try {
      CloudinaryResponse? pathImage;
      final User? userDetail =
          Provider.of<UserProvider>(context, listen: false).user;
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final String? token = sharedPreferences.getString('token');

      if (photo.isNotEmpty) {
        final cloudinary = CloudinaryPublic(cloudName, imagePreset);
        pathImage = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(photo,
              resourceType: CloudinaryResourceType.Image),
        );
      }

      final User user = User(
        id: 0,
        name: name,
        email: email,
        user: '',
        password: password,
        role: '',
        isAdmin: false,
        isActive: true,
        photo: pathImage == null ? userDetail!.photo : pathImage.secureUrl,
        createdAt: '',
        token: '',
        currentPassword: currentPassword,
        bio: bio,
        links: links,
      );

      http.Response res = await http.put(
        Uri.parse("$url/user/profile"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
          'Authorization': 'Bearer $token',
        },
        body: user.toJson(),
      );

      HttpErrorHandling().handleErrorHandling(
        context: context,
        response: res,
        onSuccess: () {
          Provider.of<UserProvider>(context, listen: false).updateUser(
            name: name.isEmpty ? userDetail!.name : name,
            email: email.isEmpty ? userDetail!.email : email,
            bio: bio,
            links: links,
            photo: pathImage == null ? userDetail!.photo! : pathImage.secureUrl,
          );
        },
      );
    } on CloudinaryException catch (err) {
      ModalSnackBar()
          .showSnackBarModal(context: context, message: err.message.toString());
    }
  }

  Future getAllUser({required BuildContext context}) async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final String? token = sharedPreferences.getString('token');

      http.Response res = await http.get(
        Uri.parse("$url/user/all"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
          'Authorization': 'Bearer $token',
        },
      );

      HttpErrorHandling().handleErrorHandling(
        context: context,
        response: res,
        onSuccess: () {
          List<User> allUser = [];
          final user = jsonDecode(res.body)['data'];
          for (int i = 0; i < user.length; i++) {
            allUser.add(User.fromMap(user[i]));
          }
          Provider.of<UserProvider>(context, listen: false).getAllUser(allUser);
        },
      );
    } catch (err) {
      ModalSnackBar()
          .showSnackBarModal(context: context, message: err.toString());
    }
  }
}
