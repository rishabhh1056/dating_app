import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/SharePerference/ParamConst.dart';
import 'package:dating_app/SharePerference/Perference.dart';
import 'package:dating_app/ThemeData/themeColors/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../getMainCollection.dart';
import '../PricingPage/PricingPage.dart';
import '../verificationScreen/VerificationScreen.dart';

class InterestsScreen extends StatefulWidget {
  @override
  _InterestsScreenState createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  // List of interests with their selected states and icons
  final List<Map<String, dynamic>> interests = [
    {'name': 'Photography', 'selected': false, 'icon': Icons.camera_alt},
    {'name': 'Cooking', 'selected': false, 'icon': Icons.restaurant},
    {'name': 'Video Games', 'selected': false, 'icon': Icons.videogame_asset},
    {'name': 'Music', 'selected': false, 'icon': Icons.music_note},
    {'name': 'Travelling', 'selected': false, 'icon': Icons.flight},
    {'name': 'Shopping', 'selected': false, 'icon': Icons.shopping_cart},
    {'name': 'Speeches', 'selected': false, 'icon': Icons.mic},
    {'name': 'Art & Crafts', 'selected': false, 'icon': Icons.palette},
    {'name': 'Swimming', 'selected': false, 'icon': Icons.pool},
    {'name': 'Drinking', 'selected': false, 'icon': Icons.local_bar},
    {'name': 'Extreme Sports', 'selected': false, 'icon': Icons.sports_motorsports},
    {'name': 'Fitness', 'selected': false, 'icon': Icons.fitness_center},
    {'name': 'Fitness', 'selected': false, 'icon': Icons.fitness_center},
    {'name': 'Fitness', 'selected': false, 'icon': Icons.fitness_center},
    {'name': 'Fitness', 'selected': false, 'icon': Icons.fitness_center},
    {'name': 'Fitness', 'selected': false, 'icon': Icons.fitness_center},
  ];

  // Toggle selection state of an interest
  void toggleSelection(int index) {
    setState(() {
      interests[index]['selected'] = !interests[index]['selected'];
    });
  }

  // Get selected interests
  List getSelectedInterests() {
    return interests
        .where((interest) => interest['selected'] == true)
        .map((interest) => interest['name'])
        .toList();
  }

  void _nextBtn()async {
    var isUser = await SharedPrefHelper.getValue(ParamConst.user, defaultValue: false);
    List getInterests = getSelectedInterests();
    DocumentReference userRef = GetMainCollection().getCollection();
    DocumentReference childRef = userRef.collection("userData").doc("interests");
    Map<String, dynamic> userData ={
      "interests": getInterests
    };
    if(isUser){
      if(getInterests.length > 4){
        childRef.set(userData);
        Navigator.push(context, MaterialPageRoute(builder: (context)=> VerificationScreen()));
      }else{
        Fluttertoast.showToast(msg: "please Select min 4 anyone");
      }
      //
    }else{
      if(getInterests.length > 4){
        childRef.set(userData);
        Navigator.push(context, MaterialPageRoute(builder: (context)=> PricingPage()));
      }else{
        Fluttertoast.showToast(msg: "please Select min 4 anyone");
      }

    }

  }


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Likes, Interests',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.purple.shade900),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text('Skip', style: TextStyle(color: Colors.blue)),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          /*gradient: LinearGradient(
            colors: [AppColors.secondaryColor, Colors.purple.shade50],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),*/
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height*0.002),

              Text(
                'Share your likes & passion with others',
                style: TextStyle(fontSize: 16, color: Colors.purple.shade600),
              ),
              SizedBox(height: height*0.05),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3.5,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: interests.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => toggleSelection(index),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: interests[index]['selected'] ? AppColors.secondaryColor : Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: interests[index]['selected'] ? Colors.white : AppColors.accentColor,
                            width: 2,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              interests[index]['icon'],
                              color: interests[index]['selected'] ? Colors.white : AppColors.primaryColor,
                            ),
                            SizedBox(width: 8),
                            Text(
                              interests[index]['name'],
                              style: TextStyle(
                                color: interests[index]['selected'] ? Colors.white : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: _nextBtn,
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.darkBackgroundColor,
                    fixedSize: Size(width, 50),
                    shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(19))
                ),

                child: Text('Next Page', style: TextStyle(color: AppColors.darkTextColor, fontSize: 18),),
              ),
              SizedBox(height: height*0.05),
            ],
          ),
        ),
      ),
    );
  }
}
