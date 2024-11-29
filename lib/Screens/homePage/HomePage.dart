import 'package:dating_app/ThemeData/themeColors/AppColors.dart';
import 'package:flutter/material.dart';

import '../profileDetailScreen/ProfileDetailScreen.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}


class _HomepageState extends State<Homepage>  {
  final List<Map<String, dynamic>> profiles = [
    {"name": "Belle Benson", "age": 28, "distance": "1.5 km away", "likes": 35, "image": "https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"},
    {"name": "Ruby Diaz", "age": 33, "distance": "1.8 km away", "likes": 81, "image": "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"},
    {"name": "Myley Corbyn", "age": 23, "distance": "1.6 km away", "likes": 49, "image": "https://images.pexels.com/photos/1987301/pexels-photo-1987301.jpeg?auto=compress&cs=tinysrgb&w=600"},
    {"name": "Tony Z.", "age": 25, "distance": "1.3 km away", "likes": 29, "image": "https://images.pexels.com/photos/27333760/pexels-photo-27333760/free-photo-of-portrait-of-a-man-smiling.jpeg?auto=compress&cs=tinysrgb&w=600"},
    {"name": "Tony Z.", "age": 25, "distance": "1.3 km away", "likes": 29, "image": "https://images.pexels.com/photos/16002545/pexels-photo-16002545/free-photo-of-very-happy-blonde-woman.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load"},
    {"name": "Tony Z.", "age": 25, "distance": "1.3 km away", "likes": 29, "image": "https://images.pexels.com/photos/27786116/pexels-photo-27786116/free-photo-of-man-in-white-shirt-sitting-backwards-on-chair.jpeg?auto=compress&cs=tinysrgb&w=600"},
    {"name": "Tony Z.", "age": 25, "distance": "1.3 km away", "likes": 29, "image": "https://images.pexels.com/photos/16999349/pexels-photo-16999349/free-photo-of-smiling-woman-with-flowers.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"},
    {"name": "Tony Z.", "age": 25, "distance": "1.3 km away", "likes": 29, "image": "https://images.pexels.com/photos/1520760/pexels-photo-1520760.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load"},
    {"name": "Tony Z.", "age": 25, "distance": "1.3 km away", "likes": 29, "image": "https://images.pexels.com/photos/18377278/pexels-photo-18377278/free-photo-of-portrait-of-elderly-woman-laughing.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load"},
    // Add more static data as needed
  ];

  bool isLiked = false;
  int _currentIndex = 0;

  final List<Widget> _pages = [
    Homepage(),
    ProfileDetailsScreen(),
    // Add other screens here that you want to navigate with BottomNavigationBar
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        maintainBottomViewPadding: true,
        top: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height*0.004,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Wrap(
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
                  ],
                ),
              ),

              SizedBox(height: 8),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: profiles.length,
                  itemBuilder: (context, index) {
                    final profile = profiles[index];
                    return GestureDetector(
                      onTap: (){
                        SnackBar(content: Text("${profile.length} item count"));
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfileDetailsScreen()));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        child: Stack(
                          children: [
                            // Background image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                profile["image"].toString(),
                                fit: BoxFit.cover,
                                height: double.infinity,
                                width: double.infinity,
                              ),
                            ),
                            // Overlay content
                            Positioned(
                              bottom: 0.0,
                              left: 0.0,
                              right: 0.0,
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.transparent,
                                      AppColors.primaryColor.withOpacity(0.8),
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      profile["name"],
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                                    ),
                                    Text(
                                      "${profile["age"]}, ${profile["distance"]}",
                                      style: TextStyle(color: Colors.white.withOpacity(0.8)),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: toggleLike,
                                          child: Icon(
                                            Icons.favorite,
                                            color: isLiked ? Colors.red : Colors.grey,
                                            size: 18,
                                          ),
                                        ),
                                        Text(
                                         profile["likes"].toString(),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );

                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
