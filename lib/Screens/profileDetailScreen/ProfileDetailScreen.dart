import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';

import '../../ThemeData/themeColors/AppColors.dart';


class ProfileDetailsScreen extends StatelessWidget {
  final List<String> images = [
    // Add URLs of the profile images here
    "https://images.unsplash.com/photo-1659736669004-6445e6aa251f?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1659736669769-1b83b8ceecd1?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1659736668293-682f7ad33297?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColors.secondaryColor, // Change this to your desired color
      statusBarIconBrightness: Brightness.light, // Set icons to light or dark
    ));

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Image carousel at the top
            CarouselSlider(
              options: CarouselOptions(
                height: height * 0.5,
                enableInfiniteScroll: true,
                autoPlay: true,
                enlargeCenterPage: true,
              ),
              items: images.map((image) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                );
              }).toList(),
            ),
            // Profile details section
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name, Age, Distance, and Online Status
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "ann_verner, 23",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Icon(Icons.circle, color: Colors.green, size: 10), // Online indicator
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.grey),
                      SizedBox(width: 4),
                      Text("43.2 km"),
                      SizedBox(width: 16),
                      Icon(Icons.female, color: Colors.pink),
                      SizedBox(width: 4),
                      Text("Female"),
                    ],
                  ),
                  SizedBox(height: 16),
                  // About section
                  Text(
                    "About",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Believes in the power of laughter and meaningful connections. Ready to embrace new adventures.",
                    style: TextStyle(color: Colors.grey[700]),
                  ),

                  SizedBox(height: 16),
                  // Interests section
                  Text(
                    "Dating Types",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Wrap(
                    spacing: 8,
                    children: [
                      Chip(label: Text("Coffee")),
                      Chip(label: Text("Lunch")),
                      Chip(label: Text("Movie")),
                      Chip(label: Text("Shopping")),
                      Chip(label: Text("Traveling")),
                      Chip(label: Text("Parties")),
                      Chip(label: Text("Seminar")),
                      Chip(label: Text("Hourly")),
                    ],
                  ),

                  SizedBox(height: 16),
                  // Interests section
                  Text(
                    "Interests",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Wrap(
                    spacing: 8,
                    children: [
                      Chip(label: Text("dancing")),
                      Chip(label: Text("volunteering")),
                      Chip(label: Text("technology")),
                      Chip(label: Text("foodie")),
                      Chip(label: Text("cooking")),
                    ],
                  ),

                  SizedBox(height: 16),
                  // Interests section
                  Text(
                    "Description",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Row for Name
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                "Name",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(": Priya Sharma"),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        // Row for Address
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                "Address",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(": South Delhi"),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        // Row for Phone
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                "Availability",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(": Friday, Sunday, Saturday, Monday, Tuesday"),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                "Skin Color",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(": Fair"),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                "Height",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(": 5 Feets"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Row(children: [
        ElevatedButton(onPressed: (){

        },
                style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.darkBackgroundColor,
                fixedSize: Size(width, 50),
                shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(19))
            ),
            child: Text("Send Request for Date..", style: TextStyle(color: Colors.white, fontSize: 18),))
      ],),
    );
  }
}
