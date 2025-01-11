import 'package:flutter/material.dart';
import 'package:instagram/routes/route_path.dart';
import 'package:instagram/screens/chat/default_chat_room.dart';
import 'package:instagram/screens/home/default_home_screen.dart';
import 'package:instagram/screens/page/chat_room.dart';
import 'package:instagram/screens/page/user_post_detail.dart';

class RouteGenerating {
  static Route<dynamic> generateRoutes(RouteSettings route) {
    switch (route.name) {
      case Routes.defaultScreen:
        return MaterialPageRoute(
            builder: (context) => const DefaultHomeScreen());
      case Routes.userPostDetail:
        return MaterialPageRoute(
            settings: route, builder: (context) => const UserPostDetail());
      case Routes.chat:
        return MaterialPageRoute(builder: (context) => const DefaultChatRoom());
      case Routes.chatRoomScreen:
        return MaterialPageRoute(builder: (context) => const ChatRoom());
      default:
        return MaterialPageRoute(
          builder: (context) {
            return const Scaffold(
              body: Center(
                child: Text("Page does not exist"),
              ),
            );
          },
        );
    }
  }
}
