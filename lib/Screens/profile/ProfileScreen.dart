import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/RiverPod/BasicDetailsNotifier.dart';
import 'package:dating_app/RiverPod/InterestsNotifier.dart';
import 'package:dating_app/Screens/LoginPage/LoginIntroPage.dart';
import 'package:dating_app/SharePerference/ParamConst.dart';
import 'package:dating_app/SharePerference/Perference.dart';
import 'package:dating_app/getMainCollection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../Service/GoogleSignIn/GoogleSignInService.dart';

class ProfileScreen extends ConsumerStatefulWidget  {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {


  GoogleSignInService signInObj = GoogleSignInService();
  User? user = FirebaseAuth.instance.currentUser;
  bool isVerified = true;

  @override
  void initState() {
    super.initState();
    final user = this.user;
    if(user != null){
      ref.read(interestsProvider.notifier).initialize(user.uid, "interests");
      ref.read(BasicDetailsProvider.notifier).fetchFirebaseData(user.uid, "BasicDetails");
      ref.read(profilePhotosProvider.notifier).fetchFirebaseData(user.uid, "profilePhotos");
      ref.read(profileVerificationProvider.notifier).fetchFirebaseData(user.uid, "profileVerification");
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    final interests = ref.watch(interestsProvider);
    final userData = ref.watch(BasicDetailsProvider);
    final photos = ref.watch(profilePhotosProvider);
    final isVerified = ref.watch(profileVerificationProvider);

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
                          backgroundImage:  NetworkImage(userData?["profileImage"]?? "https://images.pexels.com/photos/1987301/pexels-photo-1987301.jpeg?auto=compress&cs=tinysrgb&w=600"),
                        ),
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(userData?["name"]?? "N/A", // Replace with dynamic data
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: width*0.05,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text( userData?["occupation"] ?? "N/A", // Replace with dynamic data
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: width*0.04,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text( userData?["address"] ?? "N/A", // Replace with dynamic data
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
                  Positioned(
                    bottom: height*0.09, // Adjust position to align on the bottom-right
                    left: width *0.19,
                    child: SizedBox(
                      width: height * 0.03, // Size of the dot (20% of the avatar's radius)
                      height: height * 0.03,
                      child: isVerified !=null? isVerified["isVerified"] == null   ? Image.asset("assets/images/verifiedIcon.png"): Image.asset("assets/images/unVerified.png") :  CircularProgressIndicator(),
                    ),
                  ),
                ],
              ),
            ),

            // Interests Section
             Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Likes and Interests',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 15),

                  Wrap(
                    spacing: 8,
                    children: interests.isNotEmpty?
                    interests
                        .map((interest) => Chip(label: Text(interest))) // Map each string to a Chip
                        .toList(): []
                  ),
                  /*GridView.count(
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
                  ),*/
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
                      itemCount: photos?["profile_Photos"].length, // Number of photos
                      itemBuilder: (context, index) {
                        print("photos m h ${photos?["profile_Photos"][0]}");
                        final photoUrl = photos?["profile_Photos"][index];
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
                            image:  DecorationImage(
                              image: NetworkImage(photoUrl), // Replace with dynamic photo
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
