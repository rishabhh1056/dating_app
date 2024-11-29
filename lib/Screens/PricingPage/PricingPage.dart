
import 'package:flutter/material.dart';

import '../../ThemeData/themeColors/AppColors.dart';
import '../surveyPage/SurveyScreen.dart';

class PricingPage extends StatefulWidget {
  @override
  _PricingPageState createState() => _PricingPageState();
}

class _PricingPageState extends State<PricingPage> {
  final List<int> prices = [100, 200, 300, 400, 500, 600, 700, 800, 900, 1000];
  final List<String> timeLimits = [
    '1 Hour',
    '2 Hours',
    '3 Hours',
    '4 Hours',
    '5 Hours',
    '6 Hours',
    '12 Hours'
  ];
  final List<String> meetingPlaces = [ "nearMe", "10km-radius", "20km-radius", "30km-radius", "40km-radius", "50Km-range", "out of station", "anywhere", "not say yet"];

  // Map to hold selected dropdown values
  final Map<String, Map<String, dynamic>> selectedValues = {
    "For Coffee Date": {"price": null, "time": null, "place": null},
    "For Lunch Date": {"price": null, "time": null, "place": null},
    "For Dinner Date": {"price": null, "time": null, "place": null},
    "For Movie Date": {"price": null, "time": null, "place": null},
    "For Hourly Date": {"price": null, "time": null, "place": null},
    "For Traveling Date": {"price": null, "time": null, "place": null},
  };

  // Method to check if at least one dropdown is selected
  bool get isFormValid {
    return selectedValues.values.any((value) =>
    value['price'] != null &&
        value['time'] != null &&
        value['place'] != null);
  }

  // Method to create dropdowns
  Widget pricingDropdown(String heading) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8),
          DropdownButtonFormField<dynamic>(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.secondaryColor, width: 8, style: BorderStyle.solid, strokeAlign: BorderSide.strokeAlignCenter),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            items: [
              ...prices.map((price) {
                return DropdownMenuItem(
                  value: price,
                  child: Text('₹$price'),
                );
              }).toList(),
              DropdownMenuItem(
                value: 'Other',
                child: Text('Other'),
              ),
            ],
            onChanged: (value) {
              setState(() {
                selectedValues[heading]?['price'] = value;
              });
            },
            hint: Text('Select Price'),
          ),
          if (selectedValues[heading]?['price'] != null)
            Row(
              children: [
                // Time limit dropdown
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, right: 4.0),
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: AppColors.secondaryColor, width: 8, style: BorderStyle.solid, strokeAlign: BorderSide.strokeAlignCenter),

                        ),
                      ),
                      items: timeLimits.map((time) {
                        return DropdownMenuItem(
                          value: time,
                          child: Text(time),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedValues[heading]?['time'] = value;
                        });
                      },
                      hint: Text('Select Time'),
                    ),
                  ),
                ),
                // Meeting place dropdown
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 4.0),
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: AppColors.secondaryColor, width: 8, style: BorderStyle.solid, strokeAlign: BorderSide.strokeAlignCenter),

                        ),
                      ),
                      items: meetingPlaces.map((place) {
                        return DropdownMenuItem(
                          value: place,
                          child: Text(place),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedValues[heading]?['place'] = value;
                        });
                      },
                      hint: Text('Meeting Distance'),
                    ),
                  ),
                ),
              ],
            ),
          if (selectedValues[heading]?['price'] == 'Other')
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter custom price',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColors.secondaryColor, width: 8, style: BorderStyle.solid, strokeAlign: BorderSide.strokeAlignCenter),

                  ),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  selectedValues[heading]?['custom_price'] = value;
                },
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Customize Your Time & Value',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple.shade900),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              pricingDropdown("For Coffee Date"),
              pricingDropdown("For Lunch Date"),
              pricingDropdown("For Dinner Date"),
              pricingDropdown("For Movie Date"),
              pricingDropdown("For Hourly Date"),
              pricingDropdown("For Traveling Date"),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: isFormValid
                      ? () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> SurveyScreen()));
                    // Debugging selected values
                    print(selectedValues);
                  }
                      : null,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.darkBackgroundColor,
                      fixedSize: Size(width, 50),
                      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(19))
                  ),
                  child: Text(
                    "Submit",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
