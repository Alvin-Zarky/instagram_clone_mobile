import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram/models/chat_model.dart';
import 'package:instagram/services/chat_service.dart';

class ModalDeleteDialog extends StatelessWidget {
  final Chat chat;
  final int id;
  const ModalDeleteDialog({
    Key? key,
    required this.chat,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text("Notice"),
      content: const Text("Are you sure to delete message..."),
      actions: [
        RawMaterialButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Cancel"),
        ),
        RawMaterialButton(
          onPressed: () {
            ChatService().deleteUserChat(context: context, id: id, chat: chat);
          },
          child: const Text("Delete"),
        ),
      ],
    );
  }
}
