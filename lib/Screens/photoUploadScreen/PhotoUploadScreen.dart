import 'dart:io';
import 'package:dating_app/ThemeData/themeColors/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

import '../like&InterestScreen/Like&InterestPage.dart';

class PhotoUploadScreen extends StatefulWidget {
  @override
  _PhotoUploadScreenState createState() => _PhotoUploadScreenState();
}

class _PhotoUploadScreenState extends State<PhotoUploadScreen> {
  final List<XFile?> images = List.generate(6, (index) => null);
  final ImagePicker picker = ImagePicker();

  Future<void> _selectImage(int index) async {
    final XFile? pickedFile = await showDialog<XFile?>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Choose an option'),
        actions: [
          TextButton(
            onPressed: () async {
              final XFile? file = await picker.pickImage(source: ImageSource.gallery);
              Navigator.pop(context, file);
            },
            child: Text('Gallery'),
          ),
          TextButton(
            onPressed: () async {
              final XFile? file = await picker.pickImage(source: ImageSource.camera);
              Navigator.pop(context, file);
            },
            child: Text('Camera'),
          ),
        ],
      ),
    );

    if (pickedFile != null) {
      setState(() {
        images[index] = pickedFile;
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      // Shift images after the removed one to fill the gap
      for (int i = index; i < images.length - 1; i++) {
        images[i] = images[i + 1];
      }
      // Set the last item to null after shifting
      images[images.length - 1] = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Add More Photos'),
        actions: [
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (BuildContext context) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Suggested Images',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        // Display example images in a GridView
                        GridView.count(
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          children: [
                            Image.asset('assets/images/partner.jpg', fit: BoxFit.cover),
                            Image.asset('assets/images/partner.jpg', fit: BoxFit.cover),
                            Image.asset('assets/images/partner.jpg', fit: BoxFit.cover),
                            Image.asset('assets/images/partner.jpg', fit: BoxFit.cover),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Lottie.asset("assets/anim/tip_anim.json"),
            ),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Grid view of images
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 columns for vertical layout
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                ),
                itemCount: images.length,
                itemBuilder: (context, index) {
                  bool isNextToAdd = images.sublist(0, index).every((image) => image != null) && images[index] == null;

                  return GestureDetector(
                    onTap: isNextToAdd ? () => _selectImage(index) : null,
                    child: AspectRatio(
                      aspectRatio: 0.5, // Vertical aspect ratio
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.purple[50],
                          boxShadow: [
                            BoxShadow(
                              color: isNextToAdd ? AppColors.primaryColor : Colors.grey,
                              offset: Offset(0, 4),
                              blurRadius: 10,
                            ),
                          ],
                          image: images[index] != null
                              ? DecorationImage(
                            image: FileImage(File(images[index]!.path)),
                            fit: BoxFit.cover,
                          )
                              : null,
                        ),
                        child: images[index] == null
                            ? Center(
                          child: isNextToAdd
                              ? Icon(
                            Icons.add,
                            color: AppColors.accentColor,
                            size: 40,
                          )
                              : null,
                        )
                            : Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: Icon(Icons.close, color: Colors.white),
                            onPressed: () {
                              _removeImage(index);
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            ElevatedButton(
              onPressed: () {

                Navigator.push(context, MaterialPageRoute(builder: (context)=> InterestsScreen()));

              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkBackgroundColor,
                  fixedSize: Size(width, 50),
                  shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(19))
              ),

              child: Text('Next Page', style: TextStyle(color: AppColors.darkTextColor, fontSize: 18),),
            ),

            SizedBox(height: height*0.009,),
            // Note at the bottom
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                '*Add more images to complete your profile. Aim for a photo near your logo.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey[700],
                ),
              ),
            ),
            // Next Button at the bottom
          ],
        ),
      ),
    );
  }
}
