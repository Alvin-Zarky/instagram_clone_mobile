// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:instagram/models/chat_model.dart';
import 'package:instagram/models/user_model.dart';
import 'package:instagram/providers/chat_provider.dart';
import 'package:instagram/providers/user_provider.dart';
import 'package:instagram/services/post_service.dart';
import 'package:instagram/services/socket_service.dart';
import 'package:instagram/utils/custom_http_client.dart';
import 'package:instagram/utils/http_error_handling.dart';
import 'package:instagram/utils/snackbar_modal.dart';
import 'package:provider/provider.dart';

final CustomHttpClient customHttpClient = CustomHttpClient();
final SocketRepository socketRepository = SocketRepository();

class ChatService {
  Future sendMessage({
    required BuildContext context,
    required String textMessage,
  }) async {
    try {
      final User? user = Provider.of<UserProvider>(context, listen: false).user;
      final Chat chat = Chat(message: textMessage, userId: user!.id);

      http.Response response = await customHttpClient.post(
        Uri.parse("$url/chat"),
        body: chat.toJson(),
      );

      HttpErrorHandling().handleErrorHandling(
          context: context, response: response, onSuccess: () {});

      Provider.of<ChatProvider>(context, listen: false)
          .sendChat(Chat.fromMap(jsonDecode(response.body)['data']));

      return jsonDecode(response.body)['data'];
    } catch (err) {
      ModalSnackBar()
          .showSnackBarModal(context: context, message: err.toString());
    }
  }

  Future getAllUserChat({required BuildContext context}) async {
    try {
      http.Response response = await customHttpClient.get(
        Uri.parse("$url/chat"),
      );

      HttpErrorHandling().handleErrorHandling(
        context: context,
        response: response,
        onSuccess: () {
          List<Chat> allChat = [];
          for (final data in jsonDecode(response.body)['data']) {
            allChat.add(Chat.fromMap(data));
          }
          Provider.of<ChatProvider>(context, listen: false)
              .getUserChat(allChat);
        },
      );
    } catch (err) {
      ModalSnackBar()
          .showSnackBarModal(context: context, message: err.toString());
    }
  }

  Future deleteUserChat({
    required BuildContext context,
    required int id,
    required Chat chat,
  }) async {
    try {
      http.Response response = await customHttpClient.delete(
        Uri.parse("$url/chat/$id"),
      );

      HttpErrorHandling().handleErrorHandling(
        context: context,
        response: response,
        onSuccess: () {
          Provider.of<ChatProvider>(context, listen: false)
              .removeUserChat(data: chat);
          Navigator.of(context).pop();
        },
      );
    } catch (err) {
      ModalSnackBar()
          .showSnackBarModal(context: context, message: err.toString());
    }
  }
}
