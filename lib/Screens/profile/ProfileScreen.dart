import 'package:dating_app/Screens/LoginPage/LoginIntroPage.dart';
import 'package:dating_app/SharePerference/ParamConst.dart';
import 'package:dating_app/SharePerference/Perference.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../Service/GoogleSignIn/GoogleSignInService.dart';

class ProfileScreen extends StatelessWidget {

  GoogleSignInService signInObj = GoogleSignInService();
  User? user = FirebaseAuth.instance.currentUser;


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Card
            SafeArea(
              child: Stack(
                children: [
                  Container(
                    height: height/4,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue, Colors.purple],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                  ),
                  Positioned(
                    top: height*0.03,
                    right: width*0.03,
                    child: IconButton(
                      icon: const Icon(Icons.settings, color: Colors.white),
                      onPressed: () async {
                        String? uid = user?.uid;
                        await signInObj.signOutFromGoogle();
                        SharedPrefHelper.setValue(ParamConst.isLogin, false);
                        SharedPrefHelper.setValue(ParamConst.UID, null);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginIntoPage()));

                        Fluttertoast.showToast(msg: "User Logout Successfully", backgroundColor: Colors.green);
                        print("User Uid :::::::::: $uid");
                        // Navigate to settings
                      },
                    ),
                  ),
                  Positioned(
                    top: height*0.06,
                    left: width*0.04,
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: height*0.05,
                          backgroundImage: const NetworkImage("https://images.pexels.com/photos/1987301/pexels-photo-1987301.jpeg?auto=compress&cs=tinysrgb&w=600"),
                        ),
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Jenny Wilson', // Replace with dynamic data
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: width*0.05,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'London, Developer', // Replace with dynamic data
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: width*0.04,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Interests Section
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Likes and Interests',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 15),
                  GridView.count(
                    crossAxisCount: 4,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    children: List.generate(8, (index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.favorite, // Change based on interests
                          color: Colors.red,
                          size: 30,
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),

            // Photo Slider Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Photos',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 150,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5, // Number of photos
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(right: 15),
                          width: 120,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                blurRadius: 8,
                              ),
                            ],
                            image: const DecorationImage(
                              image: AssetImage('assets/example.jpg'), // Replace with dynamic photo
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
