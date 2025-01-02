import 'package:dating_app/Screens/homePage/HomePage.dart';
import 'package:dating_app/SharePerference/ParamConst.dart';
import 'package:dating_app/ThemeData/themeColors/AppColors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'Screens/LoginPage/LoginIntroPage.dart';
import 'SharePerference/Perference.dart';
import 'SplashScreen.dart';
import 'bottomNavigationBar/HomePageWrapper.dart';
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

  var isLogin = SharedPrefHelper.getValue(ParamConst.isLogin, defaultValue: false);
  var uid = SharedPrefHelper.getValue(ParamConst.UID, defaultValue: null);




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
      home: isLogin && uid !=null ? const HomePageWrapper() : const LoginIntoPage(),
      navigatorKey: navigatorKey,

    );
  }
}


