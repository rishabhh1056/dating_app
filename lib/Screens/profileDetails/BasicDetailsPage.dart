import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/ThemeData/themeColors/AppColors.dart';
import 'package:dating_app/models/basicDetailsModel/BasicDetailsModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';

import '../photoUploadScreen/PhotoUploadScreen.dart';


class BasicDetailsPage extends StatefulWidget {
  @override
  _CreateProfileScreenState createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<BasicDetailsPage> {

  User? user = FirebaseAuth.instance.currentUser;
  // DateTime currentDate = DateTime.parse("dd/mm/yyyy");
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _occupationController = TextEditingController();
  String _selectedGender= 'Male'; // Default gender selection
  String _selectedSkinColor= 'Fair'; // Default Skin Color selection
  String _selectedHeight= '5'; // Default Skin Color selection
  File? _profileImage; // Variable to hold the selected image

  // Image picker instance
  final ImagePicker _picker = ImagePicker();

  // Function to handle image selection
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  // Function to show options to select image from gallery or camera
  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Camera'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _birthdayController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  // Function to show the date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _birthdayController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }


// Function to get current location and update the address field
  Future<void> _getCurrentLocation() async {
    // Check if location permissions are granted
    PermissionStatus permissionStatus = await Permission.locationWhenInUse.status;

    // If permission is denied, request permission
    if (permissionStatus.isDenied || permissionStatus.isPermanentlyDenied) {
      // Show dialog explaining the need for location permission
      bool shouldOpenSettings = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Location Permission Required"),
            content: Text(
                "To auto-fill your address, please allow location access."),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text("Allow"),
              ),
            ],
          );
        },
      );

      if (shouldOpenSettings == true) {
        // Request location permission
        PermissionStatus status = await Permission.locationWhenInUse.request();

        // If permission is denied permanently, open app settings
        if (status.isPermanentlyDenied) {
          openAppSettings();
          return;
        }
        // If permission is still denied, do not proceed further
        if (!status.isGranted) return;
      } else {
        return; // Exit if user canceled permission dialog
      }
    }

    // Once permission is granted, get the current location
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude, position.longitude);
      Placemark place = placemarks[0];

      setState(() {
        _addressController.text =
        "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
      });
    } catch (e) {
      print("Failed to get location: $e");
      // Optionally show an error message here
    }
  }


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Create Profile', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              print("Name: ${_nameController.text}");
              print("Birthday: ${_birthdayController.text}");
              print("Gender: $_selectedGender");
            },
            child: Text(
              'Done',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Gradient Header
          Container(
            width: double.infinity,
            height: height / 5,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primaryColor, Colors.deepPurpleAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: ClipRect(
              child: Opacity(
                opacity: 0.9,
                child: Lottie.asset("assets/anim/banner_anim.json", fit: BoxFit.fitWidth, frameRate: FrameRate(700)),
              ),
            ),
          ),

          // Content
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 104), // Adjust the height for spacing

                // Profile Picture - Positioned over the banner
            GestureDetector(
              onTap: _showImagePickerOptions, // Opens the image picker popup
              child: Center(
                child: CircleAvatar(
                  radius: 70, // Increase the size for larger avatar
                  backgroundColor: Colors.white,
                  backgroundImage:
                  _profileImage != null ? FileImage(_profileImage!) : null,
                  child: _profileImage == null
                      ? Icon(
                    Icons.camera_alt,
                    color: AppColors.primaryColor,
                    size: 50,
                  )
                      : null,
                ),
              ),
            ),

                SizedBox(height: height * 0.01), // Space between avatar and fields

                // Form Fields
                    Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        ProfileTextField(
                          controller: _nameController,
                          icon: Icons.email_outlined,
                          labelText: 'Full Name',
                          maxLength: 15,
                        ),
                        SizedBox(height: height * 0.01),

                        // Birthday field with date picker
                        GestureDetector(
                          onTap: () => _selectDate(context),
                          child: AbsorbPointer(
                            child: ProfileTextField(
                              controller: _birthdayController,
                              icon: Icons.calendar_today_outlined,
                              labelText: 'Birthday',
                            ),
                          ),
                        ),


                        SizedBox(height: height * 0.01),

                        ProfileTextField(
                            controller: _occupationController,
                            icon: Icons.work,
                            labelText: "Occupation",
                        inputType: TextInputType.text,
                        maxLength: 30,),

                        SizedBox(height: height * 0.01),

                        ProfileTextField(
                          controller: _addressController,
                          icon: Icons.place,
                          labelText: "Address",
                          trailingIcon: Icons.my_location,
                          onTrailingIconTap: _getCurrentLocation,
                        ),

                        SizedBox(height: height * 0.01),

                        // Gender dropdown field
                        DropdownButtonFormField<String>(
                          value: _selectedGender,
                          icon: const Icon(Icons.arrow_drop_down, color: AppColors.secondaryColor),
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person_outline, color: AppColors.secondaryColor),
                            labelText: 'Gender',
                            labelStyle: TextStyle(color: AppColors.secondaryColor),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.secondaryColor),
                            ),
                          ),
                          items: ['Male', 'Female'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              _selectedGender = newValue!;
                            });
                          },
                        ),


                        SizedBox(height: height * 0.01),

                        // Skin Color dropdown field
                        DropdownButtonFormField<String>(
                          value: _selectedSkinColor,
                          icon: Icon(Icons.arrow_drop_down, color: AppColors.secondaryColor),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person_outline, color: AppColors.secondaryColor),
                            labelText: 'Skin Color',
                            labelStyle: TextStyle(color: AppColors.secondaryColor),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.secondaryColor),
                            ),
                          ),
                          items: ['Fair', 'Brown', 'Dark', 'Light', 'Medium', 'Olive', 'Tan', 'Deep Tan'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              _selectedSkinColor = newValue!;
                            });
                          },
                        ),

                        SizedBox(height: height * 0.01),

                    // Height dropdown field
                    DropdownButtonFormField<String>(
                      value: _selectedHeight, // Make sure this variable is properly declared
                      icon: Icon(Icons.arrow_drop_down, color: AppColors.secondaryColor),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person_outline, color: AppColors.secondaryColor),
                        labelText: 'Height', // Updated to match the dropdown purpose
                        labelStyle: TextStyle(color: AppColors.secondaryColor),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.secondaryColor),
                        ),
                      ),
                      items: ['4', '4.5', '5', '5.5', '5.7', '6', '6.3', '6.5', '6.7', '6.9', '7', '7+']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedHeight = newValue!;
                        });
                      },
                    ),

                        SizedBox(height: height*0.06,),

                        ElevatedButton(
                          onPressed: () async {

                            String? uid = user?.uid;

                            if(_nameController.text.isNotEmpty && _addressController.text.isNotEmpty &&
                                _birthdayController.text.isNotEmpty && _occupationController.text.isNotEmpty &&
                                _profileImage != null ){

                              // Reference to Firestore collection and the user's document using UID
                              DocumentReference userRef = FirebaseFirestore.instance.collection('users').doc(uid).collection("userData").doc("BasicDetails");

                              // var data = BasicDetailsModel(profileImage: _profileImage!.path.toString(), name: _nameController.text.toString(), birthday: _birthdayController.text.toString(), occupation: _occupationController.text.toString(), address: _addressController.text.toString(), gender: _selectedGender, age: "18", skinType: _selectedSkinColor.toString(), height: _selectedHeight.toString());



                              Map<String, dynamic> userData = {
                                'profileImage': "https://images.pexels.com/photos/1987301/pexels-photo-1987301.jpeg?auto=compress&cs=tinysrgb&w=600",
                                'name': _nameController.text,
                                'age': 25,
                                'address': _addressController.text,
                                'occupation': _occupationController.text,
                                'height': _selectedHeight,
                                'skin_color': _selectedSkinColor,
                                'createdAt': FieldValue.serverTimestamp(),  // Timestamp from Firebase
                              };

                              try {
                                // Set the data for the user using their UID as the document ID
                               await userRef.set(userData).then((_){
                                 Navigator.push(context, MaterialPageRoute(builder: (context)=> PhotoUploadScreen()));
                                 Fluttertoast.showToast(msg: "User Data load Successfully");
                               });
                              } catch (e) {
                                print("Error adding user data: $e");
                              }



                            }else{
                              Fluttertoast.showToast(msg: "Full-Fill All Details");
                            }

                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.darkBackgroundColor,
                              fixedSize: Size(width, 50),
                              shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(19))
                          ),

                          child: Text('Next Page', style: TextStyle(color: AppColors.darkTextColor, fontSize: 18),),
                        ),

                        SizedBox(height: height*0.09,),

                        Text("* Please enter all details accurately to keep our database organized and show you relevant information.",
                        style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),)

                    ],
                    ),
                  ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileTextField extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final String labelText;
  final IconData? trailingIcon;
  final VoidCallback? onTrailingIconTap;
  final TextInputType inputType;
  final int maxLength;

  ProfileTextField({
    required this.controller,
    required this.icon,
    required this.labelText,
    this.trailingIcon,
    this.onTrailingIconTap,
    this.inputType = TextInputType.text, // Default input type is text
    this.maxLength = 50
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType, // Set input type here
      maxLength: maxLength,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: AppColors.secondaryColor),
        labelText: labelText,
        counterText: "",
        labelStyle: TextStyle(color: AppColors.secondaryColor),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.secondaryColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor),
        ),
        suffixIcon: trailingIcon != null
            ? IconButton(
          icon: Icon(trailingIcon, color: AppColors.primaryColor),
          onPressed: onTrailingIconTap,
        )
            : null,
      ),

    );
  }
}
