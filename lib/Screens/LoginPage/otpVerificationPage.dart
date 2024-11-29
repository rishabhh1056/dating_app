
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../ThemeData/themeColors/AppColors.dart';
import '../../widget/OtpFieldWidget.dart';
import '../profileDetails/BasicDetailsPage.dart';


class Otpverificationpage extends StatefulWidget {
  const Otpverificationpage({super.key});

  @override
  State<Otpverificationpage> createState() => _OtpverificationpageState();
}

class _OtpverificationpageState extends State<Otpverificationpage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    final _formKey = GlobalKey<FormState>(); // For validation

    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            SizedBox(height: height/6,),

            Text("OTP Verification", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700                                      ),),

            SizedBox(height: height/4,
            child: Lottie.asset("assets/anim/otp_verify.json", fit: BoxFit.cover),),

            SizedBox(height: height/7,),

            OtpFieldWidget(
              onCodeChanged: (String code) {
                // Handle code changes if needed
              },
              onSubmit: (String verificationCode) {
                // Handle OTP submission logic here
              },
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {

                  Navigator.push(context, MaterialPageRoute(builder: (context)=> BasicDetailsPage()));

              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkBackgroundColor,
                  fixedSize: Size(width/2, 50),
                  shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(19))
              ),

              child: Text('Verify', style: TextStyle(color: AppColors.darkTextColor, fontSize: 18),),
            ),

          ],
        ),
      ),
    );
  }
}
