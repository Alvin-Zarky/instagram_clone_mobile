import "package:flutter/material.dart";
import 'package:instagram/models/chat_model.dart';
import 'package:instagram/models/user_model.dart';
import 'package:instagram/providers/user_provider.dart';
import 'package:instagram/controller/text_message_controller.dart';
import 'package:provider/provider.dart';

class TextMessageBox extends StatefulWidget {
  final String message;
  final String username;
  final String image;
  final int userId;
  final int id;
  final Chat chat;
  final int index;
  const TextMessageBox({
    Key? key,
    required this.message,
    required this.username,
    required this.image,
    required this.userId,
    required this.id,
    required this.chat,
    required this.index,
  }) : super(key: key);

  @override
  State<TextMessageBox> createState() => _TextMessageBoxState();
}

class _TextMessageBoxState extends State<TextMessageBox> {
  // final ChatService chatService = ChatService();
  // final SocketRepository socketRepository = SocketRepository();
  // @override
  // void initState() {
  //   super.initState();
  //   socketRepository.socketIoConnection();
  //   socketRepository.realTimeDeleteMessage(
  //     context: context,
  //     index: widget.index,
  //   );
  // }

  // void showModalDeleteButton() {
  //   showDialog(
  //       context: context,
  //       builder: ((context) =>
  //           ModalDeleteDialog(id: widget.id, chat: widget.chat)));
  // }

  late final TextMessageController _textMessageController =
      TextMessageController(
          context: context,
          id: widget.id,
          chat: widget.chat,
          index: widget.index);

  @override
  void initState() {
    _textMessageController.init();
    super.initState();
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  // @override
  // void deactivate() {
  //   super.deactivate();
  // }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  // }

  // @override
  // void didUpdateWidget(covariant TextMessageBox oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  // }

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<UserProvider>(context).user;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: widget.userId == user!.id
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          widget.userId != user.id
              ? CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Image.network(widget.image),
                )
              : const SizedBox(),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: widget.userId == user.id
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Text(
                widget.username,
                style: const TextStyle(
                  color: Colors.grey,
                  fontFamily: "Inter",
                ),
              ),
              const SizedBox(height: 5),
              GestureDetector(
                onLongPress: () {
                  _textMessageController.showModalDeleteButton();
                },
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 25, right: 25, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 44, 171, 255),
                    borderRadius: widget.userId == user.id
                        ? const BorderRadius.only(
                            bottomRight: Radius.circular(20),
                            topLeft: Radius.circular(25),
                            bottomLeft: Radius.circular(25),
                          )
                        : const BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            topRight: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                          ),
                  ),
                  child: Text(
                    widget.message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: "Inter",
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
          widget.userId == user.id
              ? CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Image.network(widget.image),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
