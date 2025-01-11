import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import "package:flutter/material.dart";
import 'package:instagram/models/post_models.dart';
import 'package:instagram/models/user_model.dart';
import 'package:instagram/providers/user_provider.dart';
import 'package:instagram/screens/page/user_comment.dart';
import 'package:instagram/services/post_service.dart';
import 'package:instagram/services/socket_service.dart';
import 'package:instagram/widgets/home/modal_delete_post.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

class PostUiData extends StatefulWidget {
  final int id;
  final String username;
  final String profileImage;
  final String text;
  final List<String> image;
  final List<String> tags;
  final int like;
  final int comment;
  final String detail;
  final dynamic createdAt;
  final List<Comments> comments;
  final List<Likes> likes;
  final int userId;
  final PostModel post;
  final int index;
  final Iterable<bool>? isLiked;
  const PostUiData({
    Key? key,
    required this.id,
    required this.username,
    required this.profileImage,
    required this.text,
    required this.tags,
    required this.image,
    required this.like,
    required this.likes,
    required this.comment,
    required this.comments,
    required this.detail,
    required this.createdAt,
    required this.userId,
    required this.post,
    required this.index,
    this.isLiked,
  }) : super(key: key);

  @override
  State<PostUiData> createState() => _PostUiDataState();
}

class _PostUiDataState extends State<PostUiData> {
  final _globalKey = GlobalKey<FormState>();

  final PostService postService = PostService();
  final SocketRepository socketRepository = SocketRepository();
  final _textComment = TextEditingController();
  String comment = '';

  @override
  void initState() {
    super.initState();
    socketRepository.socketIoConnection();
    // socketRepository.realTimeDeletePost(context: context, index: widget.index);
  }

  void showModalDeletePost() {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: ((context) {
          return FractionallySizedBox(
              child: ModalDeletePost(
            id: widget.id,
            userId: widget.userId,
            post: widget.post,
          ));
        }));
  }

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<UserProvider>(context).user;
    // print(widget.likes.map((e) => print(e.id)));
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          border: Border(
              top: BorderSide(color: Color.fromARGB(255, 227, 227, 227)))),
      child: Column(
        children: [
          Container(
            padding:
                const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 20,
                      child: Image.network(widget.profileImage),
                      // child: CachedNetworkImage(
                      //   imageUrl: widget.profileImage,
                      // ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      widget.username,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "Poppins",
                        letterSpacing: 0.5,
                      ),
                    )
                  ],
                ),
                GestureDetector(
                  onTap: showModalDeletePost,
                  child: const Icon(Icons.more_horiz),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 0),
            child: widget.image.length == 1
                ? CachedNetworkImage(
                    imageUrl: widget.image[0],
                    imageBuilder: ((context, imageProvider) {
                      return Container(
                        height: 500,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      );
                    }),
                  )
                : CarouselSlider(
                    options: CarouselOptions(height: 500),
                    items: widget.image.map((val) {
                      return Builder(builder: ((context) {
                        return Container(
                          margin: const EdgeInsets.only(left: 15, right: 15),
                          child: CachedNetworkImage(
                            imageUrl: val,
                            imageBuilder: ((context, imageProvider) {
                              return Container(
                                height: 500,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              );
                            }),
                          ),
                        );
                      }));
                    }).toList(),
                  ),
          ),
          Container(
            padding:
                const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        postService.likePost(
                          context: context,
                          id: widget.id,
                          text: widget.text,
                          media: widget.image,
                          tags: widget.tags,
                          comments: widget.comments,
                          likesPost: widget.likes,
                          index: widget.index,
                        );
                      },
                      child: widget.isLiked!.isEmpty
                          ? const Icon(
                              Icons.favorite_border,
                              size: 27,
                            )
                          : widget.isLiked!.contains(true)
                              ? const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                  size: 27,
                                )
                              : const Icon(
                                  Icons.favorite_border,
                                  size: 27,
                                ),
                    ),
                    const SizedBox(width: 17),
                    GestureDetector(
                      onTap: () {},
                      child: const Icon(
                        Icons.chat_bubble_outline,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 17),
                    GestureDetector(
                      onTap: () {},
                      child: const Icon(
                        Icons.share_outlined,
                        size: 23,
                      ),
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Icon(
                    Icons.bookmark_add_outlined,
                    size: 27,
                  ),
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding:
                const EdgeInsets.only(top: 0, left: 15, right: 15, bottom: 23),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.like} likes",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "Poppins",
                      letterSpacing: 0.5),
                ),
                const SizedBox(
                  height: 10,
                ),
                ReadMoreText(
                  widget.detail,
                  trimLines: 2,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'Show More',
                  trimExpandedText: 'Show Less',
                  colorClickableText: Colors.orange,
                  lessStyle: const TextStyle(
                      color: Color.fromARGB(255, 90, 90, 90), fontSize: 14),
                  moreStyle: const TextStyle(
                      color: Color.fromARGB(255, 90, 90, 90), fontSize: 14),
                  style: const TextStyle(height: 1.6, fontSize: 14),
                ),
                SizedBox(height: widget.comment == 0 ? 0 : 10),
                widget.comment == 0
                    ? Container()
                    : GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AllUserComment(
                                    id: widget.id,
                                    index: widget.index,
                                  )));
                        },
                        child: Text(
                          "View all ${widget.comment} comments",
                          style: const TextStyle(
                            fontFamily: "Inter",
                            color: Color.fromARGB(255, 134, 134, 134),
                          ),
                        ),
                      ),
                const SizedBox(height: 13),
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.transparent,
                        child: Image.network(user!.photo!),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        flex: 10,
                        child: Form(
                          key: _globalKey,
                          child: TextFormField(
                            enableSuggestions: false,
                            autocorrect: false,
                            controller: _textComment,
                            onChanged: (value) =>
                                setState(() => comment = value),
                            decoration: const InputDecoration(
                              hintText: 'Add a comment...',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: comment.isEmpty
                            ? const Text('')
                            : GestureDetector(
                                onTap: () {
                                  postService.postComment(
                                    context: context,
                                    id: widget.id,
                                    comments: comment,
                                    text: widget.text,
                                    media: widget.image,
                                    tags: widget.tags,
                                    index: widget.index,
                                  );
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => AllUserComment(
                                            id: widget.id,
                                            index: widget.index,
                                          )));
                                  _textComment.clear();
                                  setState(() => comment = '');
                                },
                                child: const Text(
                                  "Post",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  widget.createdAt.toString(),
                  style: const TextStyle(
                      fontSize: 13.5, fontFamily: "Inter", color: Colors.grey),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
