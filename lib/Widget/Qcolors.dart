import 'package:FireChat/config/config.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

Color Qcolors(context) {
  bool isDarkMode =
      MediaQuery.of(context).platformBrightness == Brightness.dark;

  return isDarkMode ? HexColor(darkBGColor) : HexColor(lightBGcolors);
}

Color QTextColor(context) {
  bool isDarkMode =
      MediaQuery.of(context).platformBrightness == Brightness.dark;

  return isDarkMode ? Colors.white : Colors.black;
}