import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class QText extends StatelessWidget {
  const QText({
    Key? key,
    this.size = 15,
    required this.text,
    this.fontWeight = FontWeight.normal,
  }) : super(key: key);
  final int size;

  final String text;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return PlatformText(
      text,
      textAlign: TextAlign.center,
      style: GoogleFonts.lato(
          textStyle: TextStyle(
              fontWeight: fontWeight,
              color: isDarkMode ? Colors.white : Colors.black,
              fontSize: size.sp)),
    );
  }
}
