import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';


class OtpFieldWidget extends StatelessWidget {
  final void Function(String)? onCodeChanged;
  final void Function(String)? onSubmit;

  const OtpFieldWidget({
    Key? key,
    this.onCodeChanged,
    this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildOtpTextField(context);
  }

  Widget buildOtpTextField(BuildContext context) {
    // Define color palette
    Color accentPurpleColor = Color(0xFF6A53A1);
    Color accentPinkColor = Color(0xFFF99BBD);
    Color accentDarkGreenColor = Color(0xFF115C49);
    Color accentYellowColor = Color(0xFFFFB612);
    Color accentOrangeColor = Color(0xFFEA7A3B);

    // Define text styles for each field
    List<TextStyle?> otpTextStyles = [
      createStyle(context, accentPurpleColor),
      createStyle(context, accentYellowColor),
      createStyle(context, accentDarkGreenColor),
      createStyle(context, accentOrangeColor),
      createStyle(context, accentPinkColor),
      createStyle(context, accentPurpleColor),
    ];

    // Return OtpTextField widget with customized styling
    return OtpTextField(
      numberOfFields: 6,
      borderColor: accentPurpleColor,
      focusedBorderColor: accentPurpleColor,
      styles: otpTextStyles,
      showFieldAsBox: false,
      borderWidth: 4.0,
      onCodeChanged: onCodeChanged,
      onSubmit: onSubmit,
    );
  }

  TextStyle? createStyle(BuildContext context, Color color) {
    return Theme.of(context).textTheme.displaySmall?.copyWith(color: color);
  }
}
