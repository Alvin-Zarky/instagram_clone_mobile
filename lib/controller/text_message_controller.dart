import 'package:flutter/material.dart';
import 'package:instagram/models/chat_model.dart';
import 'package:instagram/services/chat_service.dart';
import 'package:instagram/services/socket_service.dart';
import 'package:instagram/utils/state_control.dart';
import 'package:instagram/widgets/chat/modal_delete_dialog.dart';

class TextMessageController extends StateControl {
  final BuildContext context;
  final int id;
  final Chat chat;
  final int index;

  TextMessageController({
    required this.context,
    required this.id,
    required this.chat,
    required this.index,
  });

  final ChatService chatService = ChatService();
  final SocketRepository socketRepository = SocketRepository();

  @override
  void init() {
    socketRepository.socketIoConnection();
    // socketRepository.realTimeDeleteMessage(
    //   context: context,
    //   index: index,
    // );
  }

  showModalDeleteButton() {
    showDialog(
      context: context,
      builder: ((BuildContext context) => ModalDeleteDialog(
            id: id,
            chat: chat,
          )),
    );
  }

  @override
  void dispose() {}
}
