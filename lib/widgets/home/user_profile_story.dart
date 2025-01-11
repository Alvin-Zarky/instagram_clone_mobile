import "package:flutter/material.dart";

class UserProfileStory extends StatelessWidget {
  final String textName;
  final String image;
  const UserProfileStory(
      {Key? key, required this.textName, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 7),
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.transparent,
              child: Image.network(image),
              // child: CachedNetworkImage(
              //   imageUrl: image,
              // ),
            ),
          ),
          Text(
            textName,
            style: const TextStyle(color: Colors.grey, fontFamily: "Inter"),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
