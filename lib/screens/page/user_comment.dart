import 'package:cached_network_image/cached_network_image.dart';
import "package:flutter/material.dart";
import 'package:instagram/constants/constant.dart';
import 'package:instagram/providers/single_post_provider.dart';
import 'package:instagram/providers/user_provider.dart';
import 'package:instagram/services/post_service.dart';
import 'package:provider/provider.dart';

class AllUserComment extends StatefulWidget {
  final int id;
  final int index;
  const AllUserComment({Key? key, required this.id, required this.index})
      : super(key: key);

  @override
  State<AllUserComment> createState() => _AllUserCommentState();
}

class _AllUserCommentState extends State<AllUserComment> {
  final PostService postService = PostService();
  final _textComment = TextEditingController();
  String comment = '';
  @override
  void initState() {
    postService.getPostComment(context: context, id: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    final post = Provider.of<GetSinglePost>(context).post;
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.chevron_left_outlined),
                ),
                const Text(
                  "Comments",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: "Inter",
                    fontSize: 16,
                  ),
                ),
                const Icon(Icons.mail, color: Colors.transparent)
              ],
            ),
            const SizedBox(height: 15),
            Expanded(
              flex: 17,
              child: Consumer<GetSinglePost>(
                builder: ((context, value, child) {
                  return Container(
                    margin: const EdgeInsets.only(top: 15),
                    child: ListView.builder(
                      itemCount: value.post.comments?.length,
                      itemBuilder: ((context, index) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 25),
                          child: Row(
                            children: [
                              value.post.comments?[index].photo == null
                                  ? const Text("")
                                  : CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            value.post.comments![index].photo!,
                                      ),
                                    ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      value.post.comments?[index].name! ?? '',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Inter",
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(value.post.comments?[index].comment! ??
                                        ''),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Image.network(user!.photo!),
                  ),
                  const SizedBox(width: 2),
                  Expanded(
                    flex: 8,
                    child: TextFormField(
                      enableSuggestions: false,
                      autocorrect: false,
                      controller: _textComment,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(
                            left: 15, right: 15, top: 10, bottom: 10),
                        border: InputBorder.none,
                        hintText: 'Add a comment...',
                      ),
                      onChanged: (value) => setState(() => comment = value),
                    ),
                  ),
                  _textComment.text.isEmpty
                      ? const Text("")
                      : Expanded(
                          child: GestureDetector(
                            onTap: () {
                              postService.postComment(
                                context: context,
                                id: widget.id,
                                comments: comment,
                                text: post.text!,
                                media: post.media,
                                tags: post.tags,
                                index: widget.index,
                              );

                              _textComment.clear();
                              setState(() => comment = '');
                            },
                            child: Text("Post",
                                style: kTextEditProfile.copyWith(fontSize: 15)),
                          ),
                        )
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
