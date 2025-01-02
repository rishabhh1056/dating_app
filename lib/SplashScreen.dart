
import 'package:dating_app/Screens/LoginPage/LoginIntroPage.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(Duration(seconds: 3));  // Duration for splash screen
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginIntoPage()));  // Navigate to the Home Screen using GetX
    // Alternatively: Navigator.pushReplacement(
    //    context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 200,
              width: 200,
              child: Image.asset('assets/images/logo.png'),
            ),
            SizedBox(height: 10,),
            Text("Econnect Lite", style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.w600),)
          ],
        )  // Your splash screen logo
      ),
    );
  }
}
