import 'package:dating_app/ThemeData/themeColors/AppColors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'Screens/LoginPage/LoginIntroPage.dart';
import 'SharePerference/Perference.dart';
import 'firebase_options.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await SharedPrefHelper.init();
  runApp(const MyApp(),);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // Set the status bar color
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.secondaryColor, // Change this to your desired color
      statusBarIconBrightness: Brightness.light, // Set icons to light or dark
    ));
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: FToastBuilder(),
      home: const LoginIntoPage(),
      navigatorKey: navigatorKey,

    );
  }
}


