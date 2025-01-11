import "package:flutter/material.dart";
import 'package:instagram/providers/user_post_provider.dart';
import 'package:instagram/routes/route_path.dart';
import 'package:instagram/screens/setting/main_setting.dart';
import 'package:instagram/services/socket_service.dart';
import 'package:instagram/services/user_service.dart';
import 'package:provider/provider.dart';

class ProfileSetting extends StatefulWidget {
  const ProfileSetting({Key? key}) : super(key: key);

  @override
  State<ProfileSetting> createState() => _ProfileSettingState();
}

class _ProfileSettingState extends State<ProfileSetting> {
  final UserService userService = UserService();

  final SocketRepository _socketRepository = SocketRepository();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: const Icon(
                    Icons.maximize,
                    color: Colors.grey,
                    size: 35,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.only(bottom: 15),
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Color.fromARGB(255, 222, 222, 222)))),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const MainSetting()));
                      // Navigator.pushNamed(context, Routes.accountSetting);
                    },
                    child: Row(
                      children: const [
                        Icon(
                          Icons.settings_outlined,
                          size: 27,
                        ),
                        SizedBox(width: 13),
                        Text(
                          "Settings",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Inter",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    Provider.of<UserPostProvider>(context, listen: false)
                        .getPostByUser([]);
                    await userService.userSignOut(context: context);
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop();
                    // _socketRepository.socketDisconnect();
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.only(bottom: 15),
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Color.fromARGB(255, 222, 222, 222)))),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.logout_outlined,
                          size: 27,
                        ),
                        SizedBox(width: 13),
                        Text(
                          "Logout",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Inter",
                          ),
                        ),
                      ],
                    ),
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
