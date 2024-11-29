import 'package:dating_app/ThemeData/themeColors/AppColors.dart';
import 'package:flutter/material.dart';

import '../verificationScreen/VerificationScreen.dart';

class SurveyScreen extends StatefulWidget {
  @override
  _SurveyScreenState createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  // Sample questions with options
  final List<Map<String, dynamic>> questions = [
    {
      "question": "What best describes your nature?",
      "options": [
        "Friendly",
        "Reserved",
        " Fun-loving",
        "Ambitious"
      ],
      "selectedOption": null,
    },
    {
      "question": "Who would you like to Date & Meet?",
      "options": ["Only Verified", "Verified or non verified both", "Not decided yet"],
      "selectedOption": null,
    },
    {
      "question": "Who should bear the expenses during a date or meeting?",
      "options": [" The person taking me on the date will pay.", "I will pay for myself", "1st & 2nd both", "Not decided yet"],
      "selectedOption": null,
    },
    {
      "question": "Who will decide the meeting place?",
      "options": [" I will decide the meeting place.", "The person taking me on the date will decide.", "Either of us can decide.", "Not decided yet."],
      "selectedOption": null,
    },
    // Add more questions here...
  ];

  // Function to validate and submit survey
  void _submitSurvey() {
    if (questions.any((q) => q['selectedOption'] == null)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please answer all the questions!')),
      );
    } else {
      // Handle survey submission
      Navigator.push(context, MaterialPageRoute(builder: (context)=> VerificationScreen()));
      print("Survey Submitted: $questions");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Survey submitted successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Survey"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: ListView.builder(
          itemCount: questions.length,
          itemBuilder: (context, index) {
            final question = questions[index];
            return Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300, width: 1.5),
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      question["question"],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List<Widget>.generate(
                        question["options"].length,
                            (optionIndex) {
                          final option = question["options"][optionIndex];
                          return Transform.translate( // Reduce extra vertical space
                            offset: Offset(0, -8), // Adjust the value to control gap
                            child: RadioListTile(
                              contentPadding: EdgeInsets.zero, // Remove extra padding
                              dense: true, // Compact layout
                              title: Text(
                                option,
                                style: TextStyle(fontSize: 14), // Adjust font size if needed
                              ),
                              value: option,
                              groupValue: question["selectedOption"],
                              activeColor: AppColors.primaryColor, // Radio dot color
                              onChanged: (value) {
                                setState(() {
                                  question["selectedOption"] = value;
                                });
                              },
                            ),
                          );
                        },
                      ),
                    ),

                  ],
                ),
              ),
            );
          },
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: _submitSurvey,
          child: Text("Submit Survey", style: TextStyle(color: Colors.white, fontSize: 16),),
          style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.darkBackgroundColor,
              fixedSize: Size(width, 50),
              shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(19))
          ),
        ),
      ),
    );
  }
}

