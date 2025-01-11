import "package:flutter/material.dart";

class HiveLocally extends StatefulWidget {
  const HiveLocally({Key? key}) : super(key: key);

  @override
  State<HiveLocally> createState() => _HiveLocallyState();
}

class _HiveLocallyState extends State<HiveLocally> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("Collection"),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
