// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import "package:flutter_dotenv/flutter_dotenv.dart";
import 'package:http/http.dart' as http;
import 'package:instagram/models/post_models.dart';
import 'package:instagram/models/user_model.dart';
import 'package:instagram/providers/post_provider.dart';
import 'package:instagram/providers/single_post_provider.dart';
import 'package:instagram/providers/user_post_provider.dart';
import 'package:instagram/providers/user_provider.dart';
import 'package:instagram/routes/route_path.dart';
import 'package:instagram/utils/http_error_handling.dart';
import 'package:instagram/utils/snackbar_modal.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final url = dotenv.get('URI', fallback: '');
final cloudName = dotenv.get('CLOUD_NAME', fallback: '');
final uploadPreset = dotenv.get('UPLOAD_PRESET', fallback: '');

// const String url = 'http://localhost:5000/api/instagram/clone';
// const String cloudName = 'dt89p7jda';
// const String uploadPreset = 'instagram_presets';

class PostService {
  Future getAllPostData({
    required BuildContext context,
    required int offset,
  }) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final String? token = sharedPreferences.getString('token');
    try {
      http.Response res = await http.get(
        // Uri.parse("$url/post?page=1&limit=$offset"),
        Uri.parse("$url/post?limit=$offset"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=utf-8",
          "Authorization": "Bearer $token"
        },
      );

      HttpErrorHandling().handleErrorHandling(
        context: context,
        response: res,
        onSuccess: () {
          List<PostModel> post = [];
          for (final data in jsonDecode(res.body)['data']) {
            post.add(PostModel.fromMap(data));
          }
          Provider.of<PostProvider>(context, listen: false).getAllPost(post);
        },
      );
    } catch (err) {
      ModalSnackBar()
          .showSnackBarModal(context: context, message: err.toString());
    }
  }

  Future postData({
    required BuildContext context,
    required List<File> media,
    required String text,
    required int userId,
  }) async {
    try {
      List<String> pathImages = [];
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final String? token = sharedPreferences.getString('token');

      final cloudinary = CloudinaryPublic(cloudName, uploadPreset);
      if (media.isNotEmpty) {
        for (final data in media) {
          CloudinaryResponse response =
              await cloudinary.uploadFile(CloudinaryFile.fromFile(data.path));
          pathImages.add(response.secureUrl);
        }
      }

      final PostModel post = PostModel(
        text: text,
        media: pathImages,
        userId: userId,
        likes: [],
        comments: [],
        tags: [],
      );

      http.Response res = await http.post(
        Uri.parse("$url/post/"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=utf-8",
          "Authorization": "Bearer $token"
        },
        body: post.toJson(),
      );

      HttpErrorHandling().handleErrorHandling(
        context: context,
        response: res,
        onSuccess: () {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(Routes.defaultScreen, (route) => false);
        },
      );
    } catch (err) {
      ModalSnackBar()
          .showSnackBarModal(context: context, message: err.toString());
    }
  }

  Future getPostByUser({
    required BuildContext context,
  }) async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final String? token = sharedPreferences.getString('token');

      http.Response res = await http
          .get(Uri.parse("$url/post/myPost"), headers: <String, String>{
        "Content-Type": "application/json; charset=utf-8",
        "Authorization": "Bearer $token"
      });

      HttpErrorHandling().handleErrorHandling(
        context: context,
        response: res,
        onSuccess: () {
          List<PostModel> data = [];
          for (final values in jsonDecode(res.body)['data']) {
            data.add(PostModel.fromMap(values));
            // data.add(PostModel.fromJson(jsonEncode(values)));
          }
          // Provider.of<UserPostProvider>(context, listen: false)
          //     .getPostByUser(data);

          // for (int i = 0; i < (jsonDecode(res.body)['data']).length; i++) {
          // data.add(PostModel.fromJson(
          //     jsonEncode(jsonDecode(res.body)['data'][i])));
          // data.add(PostModel.fromMap(jsonDecode(res.body)['data'][i]));
          // }
          Provider.of<UserPostProvider>(context, listen: false)
              .getPostByUser(data);
        },
      );
    } catch (err) {
      ModalSnackBar()
          .showSnackBarModal(context: context, message: err.toString());
    }
  }

  Future postComment({
    required BuildContext context,
    required int id,
    required String text,
    required List<String>? media,
    required List<String>? tags,
    required String comments,
    required int index,
  }) async {
    try {
      final User? user = Provider.of<UserProvider>(context, listen: false).user;

      Comments comment = Comments(
        id: user!.id,
        name: user.name,
        email: user.email,
        photo: user.photo,
        comment: comments,
        createdAt: DateTime.now().toString(),
      );

      PostModel post = PostModel(
          likes: [], comments: [comment], media: media, tags: tags, text: text);

      http.Response res = await http.put(Uri.parse("$url/post/$id"),
          headers: <String, String>{
            "Content-Type": "application/json; charset=utf-8",
            "Authorization": "Bearer ${user.token}"
          },
          body: post.toJson());

      HttpErrorHandling().handleErrorHandling(
        context: context,
        response: res,
        onSuccess: () {
          final PostModel post =
              PostModel.fromMap(jsonDecode(res.body)['data']);
          Provider.of<PostProvider>(context, listen: false).editPost(
              id: index,
              comments: post.comments,
              text: post.text,
              media: post.media,
              likes: post.likes,
              tags: post.tags);
          Provider.of<GetSinglePost>(context, listen: false).postById(post);
        },
      );
    } catch (err) {
      ModalSnackBar()
          .showSnackBarModal(context: context, message: err.toString());
    }
  }

  Future getPostComment({
    required BuildContext context,
    required int id,
  }) async {
    try {
      final String token =
          Provider.of<UserProvider>(context, listen: false).user!.token;

      http.Response res =
          await http.get(Uri.parse("$url/post/$id"), headers: <String, String>{
        "Content-Type": "application/json; charset=utf-8",
        "Authorization": "Bearer $token"
      });

      HttpErrorHandling().handleErrorHandling(
        context: context,
        response: res,
        onSuccess: () {
          final PostModel post =
              PostModel.fromMap((jsonDecode(res.body)['data']));
          Provider.of<GetSinglePost>(context, listen: false).postById(post);
        },
      );
    } catch (err) {
      ModalSnackBar()
          .showSnackBarModal(context: context, message: err.toString());
    }
  }

  Future likePost({
    required BuildContext context,
    required int id,
    required String text,
    required List<String> media,
    required List<String> tags,
    required List<Comments> comments,
    required List<Likes> likesPost,
    required int index,
  }) async {
    try {
      final user = Provider.of<UserProvider>(context, listen: false).user;

      Likes likes = Likes(
        id: user!.id,
        name: user.name,
        email: user.email,
        photo: user.photo,
      );

      PostModel post = PostModel(
        text: text,
        media: media,
        tags: tags,
        likes: [likes],
        comments: [],
      );

      // PostModel post = PostModel(
      //   text: text,
      //   media: media,
      //   tags: tags,
      //   likes: [likes],
      //   comments: [],
      // );

      // for (final data in likesPost) {
      //   if (data.id == likes.id) {
      //     post = PostModel(
      //       text: text,
      //       media: media,
      //       tags: tags,
      //       likes: [],
      //       comments: [],
      //     );
      //   }
      // }

      http.Response res = await http.put(
        Uri.parse("$url/post/$id"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=utf-8",
          "Authorization": "Bearer ${user.token}"
        },
        body: post.toJson(),
      );

      HttpErrorHandling().handleErrorHandling(
        context: context,
        response: res,
        onSuccess: () {
          final PostModel post =
              PostModel.fromMap(jsonDecode(res.body)['data']);
          Provider.of<PostProvider>(context, listen: false).editPost(
            id: index,
            text: post.text,
            likes: post.likes,
            comments: post.comments,
            media: post.media,
            tags: post.tags,
          );
          Provider.of<GetSinglePost>(context, listen: false).postById(post);
        },
      );
    } catch (err) {
      ModalSnackBar()
          .showSnackBarModal(context: context, message: err.toString());
    }
  }

  Future deletePost({
    required BuildContext context,
    required int id,
    required PostModel post,
  }) async {
    try {
      final String? token =
          Provider.of<UserProvider>(context, listen: false).user?.token;

      http.Response res = await http
          .delete(Uri.parse("$url/post/$id"), headers: <String, String>{
        "Content-Type": "application/json; charset=utf-8",
        "Authorization": "Bearer $token"
      });

      HttpErrorHandling().handleErrorHandling(
          context: context,
          response: res,
          onSuccess: () {
            Provider.of<PostProvider>(context, listen: false)
                .deletePost(post: post);
          });
    } catch (err) {
      ModalSnackBar()
          .showSnackBarModal(context: context, message: err.toString());
    }
  }
}
