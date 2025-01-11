import "package:flutter/material.dart";
import 'package:instagram/constants/constant.dart';

class MainSetting extends StatelessWidget {
  const MainSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: Color.fromARGB(255, 221, 221, 221)))),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.chevron_left,
                          size: 32,
                        ),
                      ),
                      const Center(
                        child: Text(
                          "Settings and privacy",
                          style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Icon(
                        Icons.logout,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 30),
                padding: const EdgeInsets.only(left: 15, right: 15),
                constraints: const BoxConstraints(maxHeight: 43),
                child: TextFormField(
                  decoration: InputDecoration(
                    fillColor: const Color.fromARGB(255, 224, 224, 224),
                    filled: true,
                    hintText: 'Search...',
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    contentPadding: const EdgeInsets.only(left: 10),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 224, 224, 224)),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 224, 224, 224)),
                      borderRadius: BorderRadius.circular(13),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Your account",
                      style: kTextStyleTitleAccSetting,
                    ),
                    Image(
                      height: 17,
                      image: AssetImage("lib/assets/icon/meta.png"),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.account_circle_outlined,
                          size: 27,
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 10),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Account Centre"),
                              SizedBox(height: 3),
                              Text(
                                "Password, security, personal details, ads",
                                style: TextStyle(
                                  fontFamily: "Inter",
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Icon(Icons.chevron_right),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 25, bottom: 15),
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: RichText(
                  text: const TextSpan(
                      style: TextStyle(color: Colors.grey, height: 1.5),
                      text:
                          'Manage your connected experience and account settings across Meta technologies.',
                      children: [
                        TextSpan(
                          text: 'Learn more',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        )
                      ]),
                ),
              ),
              const Divider(
                color: Color.fromARGB(255, 237, 237, 237),
                height: 30,
                thickness: 4,
              ),
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 25),
                      padding:
                          const EdgeInsets.only(left: 15, right: 15, top: 10),
                      child: const Text(
                        "How you use instagram",
                        style: kTextStyleTitleAccSetting,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 23),
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.notifications_outlined),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Notifications",
                                style: TextStyle(
                                    fontFamily: "Inter", fontSize: 16),
                              ),
                            ],
                          ),
                          Icon(Icons.chevron_right)
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 23),
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.schedule),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Time Spent",
                                style: TextStyle(
                                    fontFamily: "Inter", fontSize: 16),
                              ),
                            ],
                          ),
                          Icon(Icons.chevron_right)
                        ],
                      ),
                    ),
                    const Divider(
                      color: Color.fromARGB(255, 237, 237, 237),
                      height: 30,
                      thickness: 4,
                    ),
                  ],
                ),
              ),
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 25),
                      padding:
                          const EdgeInsets.only(left: 15, right: 15, top: 10),
                      child: const Text(
                        "What you see",
                        style: kTextStyleTitleAccSetting,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 23),
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.star_outline),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Favourites",
                                style: TextStyle(
                                  fontFamily: "Inter",
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          Icon(Icons.chevron_right)
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 23),
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.ring_volume),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Muted Account",
                                style: TextStyle(
                                    fontFamily: "Inter", fontSize: 16),
                              ),
                            ],
                          ),
                          Icon(Icons.chevron_right)
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 23),
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.content_cut),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Suggested Content",
                                style: TextStyle(
                                    fontFamily: "Inter", fontSize: 16),
                              ),
                            ],
                          ),
                          Icon(Icons.chevron_right)
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 23),
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.heart_broken_sharp),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Hide Likes",
                                style: TextStyle(
                                    fontFamily: "Inter", fontSize: 16),
                              ),
                            ],
                          ),
                          Icon(Icons.chevron_right)
                        ],
                      ),
                    ),
                    const Divider(
                      color: Color.fromARGB(255, 237, 237, 237),
                      height: 30,
                      thickness: 4,
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 25),
                      padding:
                          const EdgeInsets.only(left: 15, right: 15, top: 10),
                      child: const Text(
                        "What you see",
                        style: kTextStyleTitleAccSetting,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 23),
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.star_outline),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Favourites",
                                style: TextStyle(
                                  fontFamily: "Inter",
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          Icon(Icons.chevron_right)
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 23),
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.ring_volume),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Muted Account",
                                style: TextStyle(
                                    fontFamily: "Inter", fontSize: 16),
                              ),
                            ],
                          ),
                          Icon(Icons.chevron_right)
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 23),
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.content_cut),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Suggested Content",
                                style: TextStyle(
                                    fontFamily: "Inter", fontSize: 16),
                              ),
                            ],
                          ),
                          Icon(Icons.chevron_right)
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 23),
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.heart_broken_sharp),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Hide Likes",
                                style: TextStyle(
                                    fontFamily: "Inter", fontSize: 16),
                              ),
                            ],
                          ),
                          Icon(Icons.chevron_right)
                        ],
                      ),
                    ),
                    const Divider(
                      color: Color.fromARGB(255, 237, 237, 237),
                      height: 30,
                      thickness: 4,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
