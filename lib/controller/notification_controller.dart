import 'package:flutter/material.dart';
import 'package:instagram/utils/state_control.dart';
import 'package:instagram/widgets/home/modal_add_data.dart';

class NotificationController extends StateControl {
  final BuildContext context;
  NotificationController({required this.context});

  bool isUpdated = true;
  showAddData({String? title, String? content, int? index}) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: ((context) {
          return FractionallySizedBox(
              heightFactor: 1,
              child: isUpdated
                  ? ModalAddData(
                      title: title,
                      content: content,
                      isEdited: isUpdated,
                      index: index,
                    )
                  : const ModalAddData());
        }));
  }
}
