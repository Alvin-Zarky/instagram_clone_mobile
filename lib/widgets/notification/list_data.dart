import "package:flutter/material.dart";
import 'package:instagram/controller/notification_controller.dart';
import 'package:instagram/models/data_locally_model.dart';
import 'package:instagram/models/user_model.dart';
import 'package:instagram/providers/user_provider.dart';
import 'package:instagram/services/list_data_service.dart';
import 'package:provider/provider.dart';

class ListData extends StatelessWidget {
  final String title;
  final String content;
  final int index;
  final DataLocally data;
  const ListData({
    Key? key,
    required this.title,
    required this.content,
    required this.data,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late NotificationController notificationController =
        NotificationController(context: context);
    final User? user = Provider.of<UserProvider>(context).user;
    return Container(
      margin: const EdgeInsets.only(top: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: Colors.transparent,
                child: Image.network(user!.photo!),
              ),
              const SizedBox(width: 13),
              Text(title),
            ],
          ),
          Row(
            children: [
              GestureDetector(
                  onTap: () {
                    notificationController.showAddData(
                        title: title, content: content, index: index);
                    notificationController.isUpdated = true;
                  },
                  child: const Icon(Icons.edit_note,
                      size: 30, color: Colors.blue)),
              const SizedBox(width: 5),
              GestureDetector(
                  onTap: () {
                    ListDataService(context: context).deleteData(data);
                  },
                  child: const Icon(Icons.delete_outline, color: Colors.red)),
            ],
          ),
        ],
      ),
    );
  }
}
