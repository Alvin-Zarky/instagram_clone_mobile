import 'package:badges/badges.dart' as badges;
import 'package:badges/badges.dart';
import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram/controller/index_controller.dart';
import 'package:instagram/models/user_model.dart';
import 'package:instagram/providers/page_provider.dart';
import 'package:instagram/providers/post_provider.dart';
import 'package:instagram/providers/user_provider.dart';
import 'package:instagram/routes/route_path.dart';
import 'package:instagram/services/post_service.dart';
import 'package:instagram/services/user_service.dart';
import 'package:instagram/widgets/home/post_ui.dart';
import 'package:instagram/widgets/home/user_profile_story.dart';
import 'package:provider/provider.dart';

class DefaultHomeScreen extends StatefulWidget {
  const DefaultHomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<DefaultHomeScreen> createState() => _DefaultHomeScreenState();
}

class _DefaultHomeScreenState extends State<DefaultHomeScreen> {
  final UserService userService = UserService();
  final PostService postService = PostService();

  final ScrollController scrollController = ScrollController();
  late IndexController indexController = IndexController(context: context);

  int offset = 5;
  bool isLoading = false;

  @override
  void initState() {
    userService.getAllUser(context: context);
    handleFetchData();
    handleInfiniteScroll();
    super.initState();
  }

  void handleFetchData() async {
    setState(() => isLoading = true);
    await postService.getAllPostData(context: context, offset: offset);
    setState(() {
      isLoading = false;
      offset = offset + 5;
    });
  }

  void handleInfiniteScroll() {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        handleFetchData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<UserProvider>(context).user;
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 15, right: 15, top: 10, bottom: 15),
              child: Column(
                children: [
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Image(
                          image:
                              AssetImage("lib/assets/icon/Instagram_logo.png"),
                          height: 50,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(Routes.chat);
                          },
                          child: Container(
                            padding: const EdgeInsets.only(top: 0, right: 5),
                            child: badges.Badge(
                              position: BadgePosition.topEnd(),
                              badgeContent: const SizedBox(
                                child: Text(
                                  "1",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              child: const FaIcon(
                                FontAwesomeIcons.message,
                                size: 22,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 9),
                        // child: ActionChip(
                        //   onPressed: () {},
                        //   backgroundColor: Colors.transparent,
                        //   label: UserProfileStory(
                        //     textName: "Your Story",
                        //     image: user?.photo ?? '',
                        //   ),
                        // ),
                        child: GestureDetector(
                          onTap: () {
                            Provider.of<PageProvider>(context, listen: false)
                                .onTapNavigate(2);
                          },
                          child: UserProfileStory(
                            textName: "Your Story",
                            image: user?.photo ?? '',
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(top: 10, left: 0),
                          height: 98,
                          child: Consumer<UserProvider>(
                              builder: ((context, value, child) {
                            return ListView.builder(
                                itemCount: value.allUser.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return UserProfileStory(
                                    textName: value.allUser[index].name,
                                    image: value.allUser[index].photo!,
                                  );
                                });
                          })),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  )
                : const SizedBox(),
            Container(
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.only(bottom: 310),
              child: Consumer<PostProvider>(
                builder: (context, value, child) {
                  return ListView.builder(
                    controller: scrollController,
                    itemCount: value.length,
                    itemBuilder: (context, index) {
                      return PostUiData(
                        id: value.post[index].id!,
                        username: value.post[index].user?.name! ?? '',
                        text: value.post[index].text ?? '',
                        tags: value.post[index].tags!,
                        image: value.post[index].media!,
                        like: value.post[index].likes!.length,
                        likes: value.post[index].likes!,
                        comment: value.post[index].comments!.length,
                        comments: value.post[index].comments!,
                        detail: value.post[index].text!,
                        createdAt: value.post[index].createdAt,
                        profileImage: value.post[index].user?.photo! ?? '',
                        userId: value.post[index].userId!,
                        post: value.post[index],
                        index: index,
                        isLiked: value.post[index].likes != null
                            ? value.post[index].likes
                                ?.map((e) => e.id == user!.id ? true : false)
                            : [],
                        // isLiked: value.post[index].likes  value.post[index].likes?[index].id == user?.id
                        //     ? true
                        //     : false,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
