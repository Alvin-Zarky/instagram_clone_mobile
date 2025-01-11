import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram/constants/constant.dart';
import 'package:instagram/providers/chat_provider.dart';
import 'package:instagram/services/chat_service.dart';
import 'package:instagram/services/socket_service.dart';
import 'package:instagram/widgets/chat/text_message.dart';
import 'package:provider/provider.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({Key? key}) : super(key: key);

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final _textMessage = TextEditingController();
  final ChatService chatService = ChatService();
  final SocketRepository socketRepository = SocketRepository();

  String message = '';
  String id = '';

  void sendMessage({required Map<String, dynamic> data}) {
    socketRepository.realTimeSendMessage(context: context, data: data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 10,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 10, bottom: 15),
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child:
                                      const Icon(Icons.chevron_left_outlined)),
                              const SizedBox(width: 10),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.transparent,
                                child: Image.asset("lib/assets/icon/user.jpg"),
                              ),
                              const SizedBox(width: 5),
                              const Text(
                                "Kenns",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          const Row(
                            children: [
                              FaIcon(FontAwesomeIcons.phone, size: 20),
                              SizedBox(width: 20),
                              FaIcon(FontAwesomeIcons.video, size: 22)
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 17,
                      child: Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: Consumer<ChatProvider>(
                          builder: ((context, value, child) {
                            return ListView.builder(
                              reverse: true,
                              itemCount: value.length,
                              itemBuilder: ((context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextMessageBox(
                                      index: index,
                                      userId: value.chat[index].userId!,
                                      message: value.chat[index].message!,
                                      username: value.chat[index].user!.name,
                                      image: value.chat[index].user!.photo,
                                      id: value.chat[index].id!,
                                      chat: value.chat[index],
                                    ),
                                  ],
                                );
                              }),
                            );
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(
              color: Colors.grey,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: [
                    Expanded(
                      flex: 8,
                      child: TextFormField(
                        enableSuggestions: false,
                        autocorrect: false,
                        controller: _textMessage,
                        onChanged: (value) => setState(() => message = value),
                        decoration: const InputDecoration(
                          hintText: 'Message...',
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                        ),
                      ),
                    ),
                    Expanded(
                        child: GestureDetector(
                      onTap: () async {
                        chatService.sendMessage(
                            context: context, textMessage: _textMessage.text);
                        setState(() {
                          _textMessage.clear();
                          message = '';
                        });
                      },
                      child: Text(
                        _textMessage.text.isEmpty ? "" : "Send",
                        style: kTextEditProfile.copyWith(fontSize: 15),
                      ),
                    ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
