import "package:flutter/material.dart";
import 'package:instagram/controller/notification_controller.dart';
import 'package:instagram/services/list_data_service.dart';

class ModalAddData extends StatefulWidget {
  final String? title;
  final String? content;
  final bool? isEdited;
  final int? index;
  const ModalAddData({
    Key? key,
    this.title,
    this.content,
    this.isEdited,
    this.index,
  }) : super(key: key);

  @override
  State<ModalAddData> createState() => _ModalAddDataState();
}

class _ModalAddDataState extends State<ModalAddData> {
  final _globalKey = GlobalKey<FormState>();
  final _textTitle = TextEditingController();
  final _textContent = TextEditingController();
  late NotificationController notificationController =
      NotificationController(context: context);

  String title = '';
  String content = '';

  @override
  void initState() {
    super.initState();
    setState(() {
      _textTitle.text = widget.title ?? "";
      _textContent.text = widget.content ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        color: Colors.white,
        child: Stack(
          children: [
            Positioned(
              top: 60,
              right: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.close,
                  size: 28,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 100),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
              child: SingleChildScrollView(
                child: Form(
                  key: _globalKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Title",
                        style: TextStyle(
                          color: Colors.blue,
                          fontFamily: "Inter",
                        ),
                      ),
                      const SizedBox(height: 2),
                      TextFormField(
                        enableSuggestions: false,
                        autocorrect: false,
                        controller: _textTitle,
                        onChanged: (value) => setState(() => title = value),
                        validator: (value) =>
                            value!.isEmpty ? "Enter title" : null,
                      ),
                      const SizedBox(height: 33),
                      const Text(
                        "Content",
                        style: TextStyle(
                          color: Colors.blue,
                          fontFamily: "Inter",
                        ),
                      ),
                      const SizedBox(height: 2),
                      TextFormField(
                        enableSuggestions: false,
                        autocorrect: false,
                        controller: _textContent,
                        maxLines: 4,
                        onChanged: (value) => setState(() => content = value),
                        validator: (value) =>
                            value!.isEmpty ? "Enter Content" : null,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (_globalKey.currentState!.validate()) {
                            widget.isEdited ?? false
                                ? ListDataService(context: context).updateData(
                                    title:
                                        title.isEmpty ? widget.title! : title,
                                    content: content.isEmpty
                                        ? widget.content!
                                        : content,
                                    index: widget.index!)
                                : ListDataService(context: context)
                                    .insertData(title: title, content: content);
                            Navigator.of(context).pop();
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 40),
                          padding: const EdgeInsets.all(13),
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                          ),
                          child: const Text(
                            "Submit",
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
