import 'package:cached_network_image/cached_network_image.dart';
import "package:flutter/material.dart";
import 'package:instagram/constants/constant.dart';
import 'package:instagram/models/post_models.dart';
import 'package:instagram/models/user_model.dart';
import 'package:instagram/providers/user_post_provider.dart';
import 'package:instagram/providers/user_provider.dart';
import 'package:instagram/routes/route_path.dart';
import 'package:instagram/services/post_service.dart';
import 'package:instagram/widgets/home/modal_edit_profile.dart';
import 'package:instagram/widgets/home/profile_event.dart';
import 'package:instagram/widgets/home/profile_setting.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileAccountScreen extends StatefulWidget {
  const ProfileAccountScreen({Key? key}) : super(key: key);

  @override
  State<ProfileAccountScreen> createState() => _ProfileAccountScreenState();
}

class _ProfileAccountScreenState extends State<ProfileAccountScreen> {
  bool isEditProfile = false;
  final PostService postService = PostService();

  @override
  void initState() {
    postService.getPostByUser(context: context);
    super.initState();
  }

  void modalSheetProfile(User user) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: isEditProfile,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(isEditProfile ? 0 : 25),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (context) {
        return isEditProfile
            ? FractionallySizedBox(
                heightFactor: 1,
                child: ModalEditProfile(
                  user: user,
                ),
              )
            : const ProfileSetting();
      },
    );
  }

  Future urlWebLunch({required String url}) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<UserProvider>(context).user;
    final List<PostModel> post = Provider.of<UserPostProvider>(context).post;
    return SafeArea(
      child: SingleChildScrollView(
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 17, right: 17, top: 10, bottom: 15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          user!.name,
                          style: const TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: const Icon(Icons.add_circle_outline),
                            ),
                            const SizedBox(width: 18),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isEditProfile = false;
                                });
                                modalSheetProfile(user);
                              },
                              child: const Icon(Icons.menu),
                            )
                          ],
                        )
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 38,
                                backgroundColor: Colors.transparent,
                                child: user.photo!.isNotEmpty
                                    ? Image.network(user.photo!)
                                    : null,
                              ),
                              const SizedBox(height: 13),
                              Text(
                                user.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Raleway",
                                  fontSize: 15,
                                  letterSpacing: 0.7,
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ProfileEvent(
                                  numberCount: user.posts ?? 0,
                                  titleEvent: "Posts"),
                              const SizedBox(width: 32),
                              ProfileEvent(
                                  numberCount: user.follower ?? 0,
                                  titleEvent: "Followers"),
                              const SizedBox(width: 32),
                              ProfileEvent(
                                  numberCount: user.following ?? 0,
                                  titleEvent: "Following"),
                              const SizedBox(width: 32),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: user.bio!.isEmpty ? 0 : 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (user.bio!.isNotEmpty)
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: user.bio, style: kTextEventProfile),
                                ],
                              ),
                            )
                          else
                            const SizedBox(height: 13),
                          // if (user.bio!.isNotEmpty) ...[
                          //   Container(),
                          //   const SizedBox()
                          // ],
                          if (user.links!.isNotEmpty)
                            GestureDetector(
                              onTap: () {
                                urlWebLunch(url: user.links!);
                              },
                              child: Text(
                                user.links ?? '',
                                style: user.links!.isNotEmpty
                                    ? kTextEventProfile.copyWith(
                                        color: const Color.fromARGB(
                                            255, 29, 86, 184),
                                        fontSize: 15)
                                    : null,
                              ),
                            ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isEditProfile = true;
                              });
                              modalSheetProfile(user);
                            },
                            child: Container(
                              width: double.infinity,
                              margin: EdgeInsets.only(
                                  top: user.bio == '' && user.links == ''
                                      ? 0
                                      : 18),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 236, 236, 236),
                                  borderRadius: BorderRadius.circular(3),
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 173, 173, 173))),
                              child: const Text(
                                "Edit Profile",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.3),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                decoration: const BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.grey))),
                child: const TabBar(
                  indicatorColor: Colors.grey,
                  tabs: [
                    Tab(
                      child: Icon(
                        Icons.grid_on,
                        size: 23,
                        color: Colors.black,
                      ),
                    ),
                    Tab(
                      child: Icon(
                        Icons.perm_contact_calendar_outlined,
                        size: 23,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 500,
                child: TabBarView(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: post.isEmpty
                            ? Container(
                                margin: const EdgeInsets.only(top: 140),
                                child: const Column(
                                  children: [
                                    Icon(
                                      Icons.photo_camera_outlined,
                                      size: 45,
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "No Posts",
                                      style: TextStyle(
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    )
                                  ],
                                ),
                              )
                            : Consumer<UserPostProvider>(
                                builder: ((context, value, child) {
                                  return GridView.builder(
                                    itemCount: value.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithMaxCrossAxisExtent(
                                      mainAxisSpacing: 5,
                                      crossAxisSpacing: 5,
                                      maxCrossAxisExtent: 150,
                                      childAspectRatio: 0.95,
                                    ),
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.of(context)
                                              .pushNamed(Routes.userPostDetail);
                                          // Navigator.of(context).pushNamedAndRemoveUntil(
                                          //     Routes.userPostDetail, (route) => true);
                                          // Navigator.of(context).pushNamedAndRemoveUntil(
                                          //     Routes.userPostDetail, (route) => false);
                                          // Navigator.of(context).push(MaterialPageRoute(
                                          //     builder: (context) =>
                                          //         const UserPostDetail()));
                                        },
                                        child: SizedBox(
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                value.post[index].media![0],
                                            imageBuilder:
                                                ((context, imageProvider) {
                                              return Container(
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .height,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.fitWidth,
                                                  ),
                                                ),
                                              );
                                            }),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }),
                              )),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 140),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.contacts_outlined,
                            size: 45,
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            "Photos and videos of you",
                            style: TextStyle(
                                fontFamily: "Inter",
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 5),
                            padding: const EdgeInsets.only(left: 35, right: 35),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: const TextSpan(
                                children: [
                                  TextSpan(
                                      style: TextStyle(
                                          color: Colors.black, height: 1.5),
                                      text:
                                          'When people tag you in photos and videos theyll appear here.')
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
