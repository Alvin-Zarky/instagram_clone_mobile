import "package:flutter/material.dart";
import 'package:instagram/controller/index_controller.dart';
import 'package:instagram/providers/chat_provider.dart';
import 'package:instagram/providers/page_provider.dart';
import 'package:instagram/screens/home/default_home_screen.dart';
import 'package:instagram/screens/home/notification_screen.dart';
import 'package:instagram/screens/home/post_data_screen.dart';
import 'package:instagram/screens/home/profile_account_screen.dart';
import 'package:instagram/screens/home/search_screen.dart';
import 'package:instagram/services/post_service.dart';
import 'package:instagram/services/socket_service.dart';
import 'package:instagram/widgets/home/bottom_navigation.dart';
import 'package:provider/provider.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({Key? key}) : super(key: key);

  @override
  State<IndexScreen> createState() => _DefaultIndexScreenState();
}

class _DefaultIndexScreenState extends State<IndexScreen> {
  // final PostService postService = PostService();
  int currentPage = 0;
  final SocketRepository socketRepository = SocketRepository();

  @override
  void initState() {
    super.initState();
    socketRepository.socketIoConnection();
    socketRepository.realTimePostData(context: context);
    socketRepository.realTimeUser(context: context);
    socketRepository.realTimeUpdatePost(context: context);

    // Update state using notifyListener()
    // socketRepository.realTimeMessageReceiver(context: context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onTapNavigate(int index) {
    setState(() {
      currentPage = index;
    });
  }

  // final List<dynamic> _page = [
  //   const DefaultHomeScreen(page: 1),
  //   const SearchFeaturesScreen(),
  //   const PostDataScreen(),
  //   const NotificationScreen(),
  //   const ProfileAccountScreen()
  // ];
  // late IndexController indexController;
  // @override
  // void initState() {
  // indexController = IndexController(context: context);
  //   super.initState();
  // }

  final List<dynamic> page = [
    const DefaultHomeScreen(),
    const SearchFeaturesScreen(),
    const PostDataScreen(),
    const NotificationScreen(),
    const ProfileAccountScreen()
  ];

  @override
  Widget build(BuildContext context) {
    // final int page = Provider.of<PageProvider>(context).currentPage;
    return Scaffold(
      bottomNavigationBar: BoxBottomNavigationBar(
        currentIndex: currentPage,
        // onTapNavigation: ((index) {
        //   Provider.of<PageProvider>(context, listen: false)
        //       .onTapNavigate(index);
        // }),
        onTapNavigation: onTapNavigate,
      ),
      // body: indexController.page[page],
      body: page[currentPage],
    );
  }
}
