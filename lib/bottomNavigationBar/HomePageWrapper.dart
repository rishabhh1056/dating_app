
import 'package:flutter/material.dart';
import 'package:dating_app/ThemeData/themeColors/AppColors.dart';

import '../Screens/homePage/HomePage.dart';
import '../Screens/photoUploadScreen/PhotoUploadScreen.dart';
import '../Screens/profile/ProfileScreen.dart';


class HomePageWrapper extends StatefulWidget {
  const HomePageWrapper({Key? key}) : super(key: key);

  @override
  _HomePageWrapperState createState() => _HomePageWrapperState();
}

class _HomePageWrapperState extends State<HomePageWrapper> {
  int _currentIndex = 0;
  late PageController _pageController;

  final List<Widget> _pages = [
    Homepage(),
    PhotoUploadScreen(),
    ProfileScreen()
    // Add other screens here that you want to navigate with BottomNavigationBar
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        backgroundColor: AppColors.secondaryColor,
        iconSize: 20,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home", backgroundColor: AppColors.secondaryColor),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Likes", backgroundColor: AppColors.secondaryColor),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Search", backgroundColor: AppColors.secondaryColor),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile", backgroundColor: AppColors.secondaryColor),
        ],
      ),
    );
  }
}
