import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/ThemeData/themeColors/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../bottomNavigationBar/HomePageWrapper.dart';
import '../../getMainCollection.dart';

class TermsAndConditionsPage extends StatefulWidget {
  @override
  _TermsAndConditionsPageState createState() => _TermsAndConditionsPageState();
}

class _TermsAndConditionsPageState extends State<TermsAndConditionsPage> {
  bool isChecked = false;
  bool isBottomReached = false;

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        setState(() {
          isBottomReached = _scrollController.position.pixels != 0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    
    return Scaffold(
      body: Column(
        children: [
          // Top section with gradient background
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurple, Colors.purpleAccent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello 👋',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Before you create an account, please read and accept our Terms & Conditions',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),

          // White background for content
          Expanded(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        SingleChildScrollView(
                          controller: _scrollController,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildSection(
                                "1. Platform Responsibility and Liability",
                                "Our platform provides a booking service where users can connect with partners (referred to as 'service providers') for scheduled dates or events, such as coffee or lunch. "
                                    "The platform itself is only a facilitator and is not responsible for any incidents that occur during or after the meeting. All interactions are at the discretion of the parties involved. "
                                    "The platform does not guarantee compatibility, safety, or the nature of interactions between users and service providers. Personal responsibility rests with the users and service providers to ensure a safe and respectful experience. "
                                    "The platform strongly advises against any illegal or harmful behavior during or after the date.",
                              ),
                              _buildSection(
                                "2. Acceptance of Requests",
                                "Service providers have full freedom to accept or decline any booking request. Accepting a booking request is at the sole discretion of the service provider, with no obligation to meet any user they are uncomfortable with. "
                                    "By accepting a request, service providers agree to follow the platform's guidelines for respectful interactions and to avoid any form of harassment or misconduct.",
                              ),
                              _buildSection(
                                "3. Payment and Charges",
                                "Service providers charge users for the time spent on the agreed-upon date, with payment made through the platform as per the rates displayed at the time of booking. "
                                    "The platform will not be held responsible for any payment disputes that arise outside of these agreed-upon charges.",
                              ),
                              _buildSection(
                                "4. Safety Measures and Location Tracking",
                                "To ensure safety, the platform may require location tracking during the time of the meeting. By using this feature, both parties agree to share their real-time location data with the platform for safety purposes only. "
                                    "Location tracking will be enabled only for the duration of the meeting and will cease once the meeting is concluded.",
                              ),
                              _buildSection(
                                "5. Conduct and User Behavior",
                                "Users and service providers are expected to maintain professional conduct during interactions. Any form of harassment, coercion, or illegal activity will not be tolerated. "
                                    "The platform reserves the right to ban any user or service provider who violates these terms or engages in inappropriate behavior.",
                              ),
                              _buildSection(
                                "6. Limitations of Liability",
                                "The platform is not liable for any personal disputes or misunderstandings that may arise between users and service providers. "
                                    "In case of any reported issues, users are advised to contact the platform's support team, who may mediate where possible but are not responsible for the behavior or actions of any individual using the platform.",
                              ),
                              _buildSection(
                                "7. Privacy and Data Usage",
                                "All personal information and location data collected during the usage of the platform are stored securely and used strictly to facilitate the meeting and ensure safety. "
                                    "The platform will not share users' personal information with any third parties, except when legally required.",
                              ),
                              _buildSection(
                                "8. Disclaimer",
                                "This app does not provide any guarantee regarding the personal safety or compatibility of individuals. Users agree to proceed with caution, and the platform encourages reporting any concerns immediately.",
                              ),
                              SizedBox(height: 100),
                            ],
                          ),
                        ),
                        if (!isBottomReached)
                          Positioned(
                            bottom: 16,
                            right: 16,
                            child: Lottie.asset("assets/anim/scroll_down.json"),
                          ),
                      ],
                    ),
                  ),

                  // Checkbox and buttons
                  Row(
                    children: [
                      Checkbox(
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                      ),
                      Expanded(
                        child: Text(
                          'I have read and agree to the Terms & Conditions',
                          style: TextStyle(color: Colors.black87),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Decline", style: TextStyle(color: Colors.black54)),
                      ),
                      ElevatedButton(
                        onPressed: isChecked ? () {
                          DocumentReference userRef = GetMainCollection().getCollection();
                          DocumentReference childRef = userRef.collection("userData").doc("term&condition");

                          Map<String, dynamic> userData ={
                            "isChecked": isChecked
                          };

                          childRef.set(userData);
                         Navigator.push(context, MaterialPageRoute(builder: (context)=> const HomePageWrapper()));
                        } : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isChecked ? AppColors.secondaryColor : Colors.deepPurple[200],
                          foregroundColor: Colors.white,
                          fixedSize: Size.fromWidth(width*0.6)
                        ),
                        child: const Text("Accept"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          SizedBox(height: 4),
          Text(
            content,
            style: TextStyle(fontSize: 14, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
