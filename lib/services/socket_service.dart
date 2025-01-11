import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:instagram/models/chat_model.dart';
import 'package:instagram/models/post_models.dart';
import 'package:instagram/models/user_model.dart';
import 'package:instagram/providers/chat_provider.dart';
import 'package:instagram/providers/post_provider.dart';
import 'package:instagram/providers/single_post_provider.dart';
import 'package:instagram/providers/user_provider.dart';
import 'package:provider/provider.dart';
import "package:socket_io_client/socket_io_client.dart" as io;

class SocketRepository {
  final url = dotenv.get('HOST_URL', fallback: '');
  // final String url = 'http://localhost:5000/';

  late io.Socket _socket;
  void socketIoConnection() {
    _socket = io.io(
      url,
      io.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );
    _socket.connect();
  }

  void socketDisconnect() {
    _socket.onDisconnect((_) => debugPrint('disconnect'));
  }

  void realTimePostData({required BuildContext context}) {
    _socket.on('post-data', (data) {
      Provider.of<PostProvider>(context, listen: false)
          .insertPost(PostModel.fromMap(data));
    });
  }

  void realTimeUser({required BuildContext context}) {
    _socket.on('user-register', (data) {
      Provider.of<UserProvider>(context, listen: false)
          .insertUser(User.fromMap(data));
    });
  }

  void realTimeUpdatePost({
    required BuildContext context,
  }) {
    _socket.on('update-post', (data) {
      // print(data);
      final PostModel post = PostModel.fromMap((data));
      Provider.of<GetSinglePost>(context, listen: false).postById(post);
    });
  }

  void realTimeDeletePost({required BuildContext context, required int index}) {
    _socket.on('delete-post', (data) {
      // Provider.of<PostProvider>(context, listen: false)
      //     .deletePost(post: PostModel.fromMap(data));
      Provider.of<PostProvider>(context, listen: false)
          .removePost(index: index);
    });
  }

  void realTimeSendMessage(
      {required BuildContext context, required Map<String, dynamic> data}) {
    _socket.emit("message", data);
  }

  void realTimeMessageReceiver({required BuildContext context}) {
    _socket.on('message-receiver', (data) {
      // Update state using notifyListener()
      Provider.of<ChatProvider>(context, listen: false)
          .sendChat(Chat.fromMap(data));
    });
  }

  void realTimeDeleteMessage(
      {required BuildContext context, required int index}) {
    _socket.on('delete-chat', (data) {
      Provider.of<ChatProvider>(context, listen: false)
          .removeIndexUserChat(index);
      // Provider.of<ChatProvider>(context, listen: false)
      //     .removeUserChat(data: data);
    });
  }
}
