import "package:flutter/material.dart";

class ProfileEvent extends StatelessWidget {
  final int numberCount;
  final String titleEvent;
  const ProfileEvent(
      {Key? key, required this.numberCount, required this.titleEvent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Text(
            numberCount.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 3),
          Text(titleEvent)
        ],
      ),
    );
  }
}
