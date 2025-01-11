import 'package:flutter/material.dart';
import "package:flutter/services.dart";
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:instagram/providers/chat_provider.dart';
import 'package:instagram/providers/data_locally_provider.dart';
import 'package:instagram/providers/page_provider.dart';
import 'package:instagram/providers/post_provider.dart';
import 'package:instagram/providers/single_post_provider.dart';
import 'package:instagram/providers/user_post_provider.dart';
import 'package:instagram/providers/user_provider.dart';
import 'package:instagram/screens/main_screen.dart';
import 'package:instagram/utils/route_setting.dart';
import 'package:provider/provider.dart';
import "package:hive_flutter/hive_flutter.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await Hive.initFlutter();
  await Hive.openBox('dataView');
  await dotenv.load(fileName: '.env');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => PostProvider()),
        ChangeNotifierProvider(create: (_) => UserPostProvider()),
        ChangeNotifierProvider(create: (_) => GetSinglePost()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
        ChangeNotifierProvider(create: (_) => PageProvider()),
        ChangeNotifierProvider(create: (_) => DataLocallyProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Instagram Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (settings) => RouteGenerating.generateRoutes(settings),
      home: const MainScreen(),
    );
  }
}
