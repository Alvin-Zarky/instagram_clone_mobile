import "package:flutter/material.dart";
import 'package:hive_flutter/hive_flutter.dart';

class HiveLocally extends StatefulWidget {
  const HiveLocally({Key? key}) : super(key: key);

  @override
  State<HiveLocally> createState() => _HiveLocallyState();
}

class _HiveLocallyState extends State<HiveLocally> {
  final _myBox = Hive.box('dataView');
  @override
  Widget build(BuildContext context) {
    print(_myBox);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: const [
              Text("Collection"),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
