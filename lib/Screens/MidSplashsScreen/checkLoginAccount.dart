import 'package:dating_app/Screens/LoginPage/LoginIntroPage.dart';
import 'package:dating_app/Screens/profileDetails/BasicDetailsPage.dart';
import 'package:dating_app/bottomNavigationBar/HomePageWrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../../RiverPod/BasicDetailsNotifier.dart';

class checkLoginAccount extends ConsumerStatefulWidget {
  @override
  ConsumerState<checkLoginAccount> createState() => _checkLoginAccountState();
}

class _checkLoginAccountState extends ConsumerState<checkLoginAccount> {
  User? user = FirebaseAuth.instance.currentUser;
  Map<String, dynamic> isCompleteProfile = {};
  late bool? isChecked;
  @override
  void initState() {
    super.initState();
    final user = this.user;
    if(user != null){
      _initializeApp();
    }
  }


  void _initializeApp() async {
    await ref.read(termAndConditionDetailProvider.notifier).fetchFirebaseData(user!.uid, "term&condition"); // Simulating the API call
    isChecked = await ref.watch(termAndConditionDetailProvider)?["isChecked"];
    await Future.delayed(Duration(seconds: 3));
    _navigateToHomeScreen();
  }



  void _navigateToHomeScreen() {
    if(isChecked != null){
      if(isChecked!){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> const HomePageWrapper()));
      }
      else{
        Navigator.push(context, MaterialPageRoute(builder: (context)=> BasicDetailsPage()));
      }
    }else{
      Navigator.push(context, MaterialPageRoute(builder: (context)=>  BasicDetailsPage()));
    }

  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset("assets/anim/profile_check_anim.json", height: height*0.5, width: width*0.8 ),
            SizedBox(height: 20),
            const Center(
              child: SizedBox(
                width: 250,
                child: Text(
                  "Just a moment, we’re checking your account information.",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
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
