import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram/models/user_model.dart';
import 'package:instagram/providers/user_provider.dart';
import 'package:instagram/routes/route_path.dart';
import 'package:instagram/services/chat_service.dart';
import 'package:instagram/services/socket_service.dart';
import 'package:instagram/widgets/chat/user_profile_room.dart';
import 'package:provider/provider.dart';

class DefaultChatRoom extends StatefulWidget {
  const DefaultChatRoom({Key? key}) : super(key: key);

  @override
  State<DefaultChatRoom> createState() => _DefaultChatRoomState();
}

class _DefaultChatRoomState extends State<DefaultChatRoom> {
  final ChatService chatService = ChatService();
  final SocketRepository socketRepository = SocketRepository();

  @override
  void initState() {
    // socketRepository.socketIoConnection();
    chatService.getAllUserChat(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final User? user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 15),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: const Icon(Icons.chevron_left_outlined),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            user?.name ?? '',
                            style: const TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          GestureDetector(
                              onTap: () {},
                              child: const FaIcon(FontAwesomeIcons.video,
                                  size: 22)),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    padding: const EdgeInsets.only(left: 2, right: 2),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        contentPadding: const EdgeInsets.all(1),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 25),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Messages",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "Poppins",
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "Requests",
                          style: TextStyle(
                            color: Color.fromARGB(255, 139, 139, 139),
                            fontFamily: "Inter",
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: size.width,
                    margin: const EdgeInsets.only(top: 17),
                    child: Column(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(Routes.chatRoomScreen);
                            },
                            child: const UserProfileRoom()),
                        GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(Routes.chatRoomScreen);
                            },
                            child: const UserProfileRoom()),
                        GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(Routes.chatRoomScreen);
                            },
                            child: const UserProfileRoom()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
