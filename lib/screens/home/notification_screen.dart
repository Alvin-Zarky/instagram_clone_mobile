import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:instagram/controller/notification_controller.dart';
import 'package:instagram/providers/data_locally_provider.dart';
import 'package:instagram/widgets/notification/list_data.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late NotificationController notificationController =
      NotificationController(context: context);

  @override
  void initState() {
    super.initState();
    Provider.of<DataLocallyProvider>(context, listen: false).loadData();
  }

  @override
  Widget build(BuildContext context) {
    final int length = Provider.of<DataLocallyProvider>(context).length;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          notificationController.showAddData();
          setState(() {
            notificationController.isUpdated = false;
          });
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Notification",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: "Poppins",
                    fontSize: 25,
                  ),
                ),
                const SizedBox(height: 25),
                const Text(
                  "All Data",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    fontFamily: "Poppins",
                  ),
                ),
                SizedBox(
                  height: 800,
                  child: Consumer<DataLocallyProvider>(
                    builder: ((context, value, child) {
                      return ListView.builder(
                        itemCount: length,
                        itemBuilder: ((context, index) {
                          return ListData(
                            title: value.data[index].title!,
                            content: value.data[index].content!,
                            data: value.data[index],
                            index: index,
                          );
                        }),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
