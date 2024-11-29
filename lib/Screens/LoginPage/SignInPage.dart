
import 'package:dating_app/Screens/profileDetails/BasicDetailsPage.dart';
import 'package:dating_app/Service/FirebaseOtpService/PhoneVerificationService.dart';
import 'package:dating_app/Service/GoogleSignIn/GoogleSignInService.dart';
import 'package:dating_app/ThemeData/themeColors/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'otpVerificationPage.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>(); // For validation
  final TextEditingController _phoneController = TextEditingController();
  ValueNotifier userCredential = ValueNotifier(''); // for Google SignIn
  GoogleSignInService signInObj = GoogleSignInService();
  PhoneVerificationService  phoneVerificationService = PhoneVerificationService();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.1),
          child: Column(
            children: [

              SizedBox(height: height/6,),
              Center(
                child: SizedBox(height: height/7,
                child: Image.asset("assets/images/logo.png")),
              ),

              SizedBox(height: height * 0.08,),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,),
                ),
              ),

              SizedBox(height: height * 0.04,),

              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Enter Your Phone Number',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),

              SizedBox(height: 10),

              Form(
                key: _formKey,
                child: TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  maxLength: 13,

                  decoration: InputDecoration(
                    hintText: '98912 XXXXX',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a phone number';
                    }
                    return null;
                  },
                ),
              ),

              SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  String formatPhoneNumber(String phoneNumber) {
                    if (!phoneNumber.startsWith('+')) {
                      return '+91$phoneNumber'; // Add default country code (India).
                    }
                    return phoneNumber;
                  }

                  if (_formKey.currentState!.validate()) {
                    // Handle successful validation
                    phoneVerificationService.verifyPhoneNumber(formatPhoneNumber(_phoneController.toString()));

                    Fluttertoast.showToast(
                        msg: "Processing.....",
                        gravity: ToastGravity.CENTER,
                        backgroundColor: Colors.greenAccent,
                        textColor: Colors.black,
                        toastLength: Toast.LENGTH_LONG);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Otpverificationpage()));
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.darkBackgroundColor,
                    fixedSize: Size(width, 50),
                    shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(19))
                ),

                child: Text('Submit', style: TextStyle(color: AppColors.darkTextColor, fontSize: 18),),
              ),

             SizedBox(height: height*0.06,),
              
              const Text("----------------Or----------------", style: TextStyle(color: Colors.black, fontSize: 22),),

              SizedBox(height: height*0.06,),
              
              OutlinedButton(
                  onPressed: () async {

                    userCredential.value = await signInObj.signInWithGoogle();

                    if (userCredential.value != null && userCredential.value.user != null) {
                      // Check if essential user information is available
                      final user = userCredential.value.user!;
                      if (user.email != null && user.email!.isNotEmpty) {
                        // Successfully signed in
                        Fluttertoast.showToast(
                          msg: "Successfully signed in with ${user.email}",
                        gravity: ToastGravity.CENTER,
                        backgroundColor: Colors.greenAccent,
                        textColor: Colors.black,
                        toastLength: Toast.LENGTH_LONG);

                        // Navigate to BasicDetailsPage
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BasicDetailsPage()),
                        );
                      } else {
                        // Handle case where email is unavailable

                        Fluttertoast.showToast(
                            msg: "Sign-in successful, but email information is missing.",
                            gravity: ToastGravity.CENTER,
                            backgroundColor: Colors.greenAccent,
                            textColor: Colors.black,
                            toastLength: Toast.LENGTH_LONG);

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BasicDetailsPage()),
                        );

                      }
                    } else {
                      // Handle unsuccessful sign-in
                      Fluttertoast.showToast(
                          msg: "Google Sign-In failed. Please try again.",
                          gravity: ToastGravity.CENTER,
                          backgroundColor: Colors.redAccent,
                          textColor: Colors.black,
                          toastLength: Toast.LENGTH_LONG);
                    }




                  },
                  style: OutlinedButton.styleFrom(
                      fixedSize: Size(width, 50),
                      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(19),),
                      side: const BorderSide(color: AppColors.secondaryColor,width: 1)
                  ),

                  child: Row(
                    children: [
                      Image.asset("assets/images/google_icon.png",height: 35, width: 35,),
                      SizedBox(width: width/9,),
                      const Text("Signup with Google", style: TextStyle(fontSize: 18, color: Colors.black),)
                    ],
                  )),

            ],
          ),
        ),
      ),
    );
  }
}
