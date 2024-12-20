
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../ThemeData/themeColors/AppColors.dart';
import '../term&conditionPage/Term&ConditionPage.dart';


class VerificationScreen extends StatefulWidget {
  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  File? _profileImage;
  File? _documentImage;
  File? _aadhaarFrontImage;
  File? _aadhaarBackImage;
  String? selectedDocumentType;
  final picker = ImagePicker();

  // Function to pick image from camera for profile
  Future<void> _pickProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _profileImage = File(pickedFile.path);
      }
    });
  }

  // Function to pick image for a document
  Future<void> _pickDocumentImage(ImageSource source, bool isAadhaarFront) async {
    final pickedFile = await picker.pickImage(source: source);
    setState(() {
      if (pickedFile != null) {
        if (selectedDocumentType == 'Aadhaar' && isAadhaarFront) {
          _aadhaarFrontImage = File(pickedFile.path);
        } else if (selectedDocumentType == 'Aadhaar' && !isAadhaarFront) {
          _aadhaarBackImage = File(pickedFile.path);
        } else {
          _documentImage = File(pickedFile.path);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Verification',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.purple.shade900),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> TermsAndConditionsPage()));
            },
            child: Text('Skip', style: TextStyle(color: AppColors.accentColor)),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile Image Section
            GestureDetector(
              onTap: _pickProfileImage,
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey.shade300,
                backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
                child: _profileImage == null
                    ? Icon(Icons.camera_alt, color: Colors.grey, size: 30)
                    : null,
              ),
            ),
            SizedBox(height: 20),

            // Title and Subtitle
            Text(
              'Upload ID',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.secondaryColor),
            ),
            Text(
              'We strongly give full freedom to our users, but to avoid any kind of mishap & nuisance we recommend you to provide an ID proof for safety & security.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade700),
            ),
            SizedBox(height: 20),

            // Document Type Dropdown
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.secondaryColor),
              ),
              child: DropdownButton<String>(
                value: selectedDocumentType,
                hint: Text("ID Proof", style: TextStyle(color: AppColors.secondaryColor),),
                isExpanded: true,
                underline: SizedBox(),
                items: ['Passport', 'Driver’s License', 'National ID', 'Aadhaar'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedDocumentType = newValue;
                  });
                },
              ),
            ),
            SizedBox(height: 20),

            // Document Upload Box
            if (selectedDocumentType != 'Aadhaar')
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (_) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: Icon(Icons.camera_alt),
                            title: Text('Camera'),
                            onTap: () {
                              Navigator.pop(context);
                              _pickDocumentImage(ImageSource.camera, true);
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.photo_library),
                            title: Text('Gallery'),
                            onTap: () {
                              Navigator.pop(context);
                              _pickDocumentImage(ImageSource.gallery, true);
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Container(
                  height: height / 5,
                  width: width,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.secondaryColor, width: 1.5),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.purple.shade50,
                  ),
                  child: _documentImage != null
                      ? Image.file(_documentImage!, fit: BoxFit.cover)
                      : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.file_upload, color: Colors.purple.shade300, size: 50),
                      Text('Upload Document', style: TextStyle(color: Colors.purple.shade300)),
                    ],
                  ),
                ),
              ),

            // Aadhaar Upload Boxes for front and back
            if (selectedDocumentType == 'Aadhaar')
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (_) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                leading: Icon(Icons.camera_alt),
                                title: Text('Camera (Front)'),
                                onTap: () {
                                  Navigator.pop(context);
                                  _pickDocumentImage(ImageSource.camera, true);
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.photo_library),
                                title: Text('Gallery (Front)'),
                                onTap: () {
                                  Navigator.pop(context);
                                  _pickDocumentImage(ImageSource.gallery, true);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Container(
                      height: height / 5,
                      width: width,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.secondaryColor, width: 1.5),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.purple.shade50,
                      ),
                      child: _aadhaarFrontImage != null
                          ? Image.file(_aadhaarFrontImage!, fit: BoxFit.cover)
                          : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.file_upload, color: Colors.purple.shade300, size: 50),
                          Text('Upload Aadhaar Front', style: TextStyle(color: Colors.purple.shade300)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (_) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                leading: Icon(Icons.camera_alt),
                                title: Text('Camera (Back)'),
                                onTap: () {
                                  Navigator.pop(context);
                                  _pickDocumentImage(ImageSource.camera, false);
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.photo_library),
                                title: Text('Gallery (Back)'),
                                onTap: () {
                                  Navigator.pop(context);
                                  _pickDocumentImage(ImageSource.gallery, false);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Container(
                      height: height / 5,
                      width: width,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.secondaryColor, width: 1.5),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.purple.shade50,
                      ),
                      child: _aadhaarBackImage != null
                          ? Image.file(_aadhaarBackImage!, fit: BoxFit.cover)
                          : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.file_upload, color: Colors.purple.shade300, size: 50),
                          Text('Upload Aadhaar Back', style: TextStyle(color: Colors.purple.shade300)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            SizedBox(height: 20),

            // Continue Button
            ElevatedButton(
              onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> TermsAndConditionsPage()));
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkBackgroundColor,
                  fixedSize: Size(width, 50),
                  shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(19))),
              child: Text('Next Page', style: TextStyle(color: AppColors.darkTextColor, fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
