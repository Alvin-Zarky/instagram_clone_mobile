import "package:flutter/material.dart";
import 'package:instagram/models/user_model.dart';
import 'package:instagram/providers/user_provider.dart';
import 'package:provider/provider.dart';

class UserProfileRoom extends StatelessWidget {
  const UserProfileRoom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<UserProvider>(context).user;
    return Container(
      width: double.infinity,
      color: Colors.transparent,
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.transparent,
                child: Image.network(user?.photo ?? ''),
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    user?.name ?? '',
                    style: const TextStyle(fontFamily: "Inter"),
                  ),
                  const SizedBox(height: 3),
                  const Text(
                    "Active 36mn ago",
                    style: TextStyle(color: Colors.grey, fontFamily: "Inter"),
                  ),
                  const SizedBox(height: 3),
                ],
              ),
            ],
          ),
          GestureDetector(
            onTap: () {},
            child: const Icon(Icons.photo_camera_outlined),
          )
        ],
      ),
    );
  }
}
