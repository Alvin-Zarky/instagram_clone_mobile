import 'package:flutter/material.dart';
import 'package:instagram/models/post_models.dart';
import 'package:instagram/providers/user_provider.dart';
import 'package:instagram/services/post_service.dart';
import 'package:provider/provider.dart';

class ModalDeletePost extends StatefulWidget {
  final int id;
  final int userId;
  final PostModel post;
  const ModalDeletePost({
    Key? key,
    required this.id,
    required this.userId,
    required this.post,
  }) : super(key: key);

  @override
  State<ModalDeletePost> createState() => _ModalDeletePostState();
}

class _ModalDeletePostState extends State<ModalDeletePost> {
  final PostService postService = PostService();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final user = Provider.of<UserProvider>(context, listen: false).user;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
        child: Column(
          children: [
            SizedBox(
              width: size.width,
              child: const Icon(
                Icons.maximize,
                size: 35,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 15),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 228, 228, 228)),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: 18,
                        right: 18,
                        top: 13,
                        bottom: widget.userId == user!.id ? 5 : 15),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.bookmark_outline,
                          size: 30,
                        ),
                        SizedBox(width: 13),
                        Text(
                          "Save to collection",
                          style: TextStyle(fontSize: 15, fontFamily: "Inter"),
                        )
                      ],
                    ),
                  ),
                  widget.userId == user.id
                      ? const Divider(
                          color: Colors.grey,
                        )
                      : const SizedBox(),
                  widget.userId == user.id
                      ? GestureDetector(
                          onTap: () {
                            postService.deletePost(
                                context: context,
                                id: widget.id,
                                post: widget.post);
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.only(
                                left: 18, right: 18, top: 5, bottom: 13),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.block_outlined,
                                  size: 30,
                                ),
                                SizedBox(width: 13),
                                Text(
                                  "Delete post",
                                  style: TextStyle(
                                      fontSize: 15, fontFamily: "Inter"),
                                )
                              ],
                            ),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
