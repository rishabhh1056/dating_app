
import 'package:dating_app/SharePerference/ParamConst.dart';
import 'package:dating_app/SharePerference/Perference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../ThemeData/themeColors/AppColors.dart';
import 'SignInPage.dart';


class LoginIntoPage extends StatefulWidget {
  const LoginIntoPage({super.key});

  @override
  State<LoginIntoPage> createState() => _LoginIntoPageState();
}

class _LoginIntoPageState extends State<LoginIntoPage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/background_image.png"),
            fit: BoxFit.cover,
            opacity: 0.5,
            colorFilter: ColorFilter.mode(
                AppColors.lightAccentColor.withOpacity(0.5),
                BlendMode
                    .lighten) // Uncomment if you want to use it after testing

            ),
      ),
      child: SingleChildScrollView(
          child: Center(
        child: Column(
          children: [
            SizedBox(
              height: height / 6,
            ),
            SizedBox(
              height: height / 7,
              width: width / 4,
              child: Image(image: AssetImage("assets/images/logo.png")),
            ),

            SizedBox(
              height: height / 3,
            ),

            Card(
              margin: EdgeInsets.symmetric(horizontal: width / 4),
              elevation: 8,
              shadowColor: Colors.black26,
              color: Colors.white.withOpacity(0.5),
              shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Center(
                child: Text(
                  "Join Us",
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.pink,
                    fontFamily: "heading",
                  ),
                ),
              ),
            ),

            SizedBox(height: height / 15),

            // Row containing two cards
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // First Card
                Expanded(
                  child: InkWell(
                    onTap: () async{
                      await SharedPrefHelper.setValue(ParamConst.user, true);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignInPage()));
                    },
                    child: Card(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      elevation: 4,
                      shadowColor: Colors.black26,
                      color: Colors.white.withOpacity(0.6),
                      shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/images/customer.png", // Replace with your image path
                              height: height / 10,
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Users",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Second Card
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      await SharedPrefHelper.setValue(ParamConst.user, false);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignInPage()));
                    },
                    child: Card(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      elevation: 4,
                      shadowColor: Colors.black26,
                      color: Colors.white.withOpacity(0.6),
                      shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/images/partner_icon.png", // Replace with your image path
                              height: height / 10,
                            ),
                            SizedBox(height: 10),
                            const Text(
                              "Partner",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      )),
    ));
  }
}
