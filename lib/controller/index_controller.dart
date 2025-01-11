import 'package:flutter/material.dart';
import 'package:instagram/screens/home/default_home_screen.dart';
import 'package:instagram/screens/home/notification_screen.dart';
import 'package:instagram/screens/home/post_data_screen.dart';
import 'package:instagram/screens/home/profile_account_screen.dart';
import 'package:instagram/screens/home/search_screen.dart';
import 'package:instagram/services/post_service.dart';
import 'package:instagram/services/socket_service.dart';
import 'package:instagram/utils/state_control.dart';

class IndexController extends StateControl {
  final BuildContext context;
  IndexController({required this.context}) {
    init();
  }

  final PostService postService = PostService();
  final SocketRepository socketRepository = SocketRepository();

  @override
  void init() {
    super.init();
    socketRepository.socketIoConnection();
    socketRepository.realTimePostData(context: context);
    socketRepository.realTimeUser(context: context);
    socketRepository.realTimeUpdatePost(context: context);
    socketRepository.realTimeMessageReceiver(context: context);
  }

  final List<dynamic> page = [
    const DefaultHomeScreen(),
    const SearchFeaturesScreen(),
    const PostDataScreen(),
    const NotificationScreen(),
    const ProfileAccountScreen()
  ];

  @override
  void dispose() {}
}
