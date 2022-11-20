import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class CustomStyle {
  static List<Color> colorPalette = [
    Color.fromARGB(255, 117, 79, 68),
    Color.fromARGB(255, 247, 130, 84),
    Color.fromARGB(255, 242, 193, 78),
    Color.fromARGB(255, 151, 171, 177),
    Color.fromARGB(255, 255, 255, 255),
    Colors.black54
  ];

  static double massiveTitleSize = 60.0;
  static double subMassiveTitleSize = 45.0;
  static double averageSize = 25.0;
  static double subAverageSize = 15.0;
  static double miniSize = 10.0;

  static ThemeData signInUpCustomTheme = ThemeData(
      //background color
      canvasColor: CustomStyle.colorPalette[2],

      //text buttons
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor:
              MaterialStateProperty.all<Color>(CustomStyle.colorPalette[4]),
        ),
      ),
      //outlined buttons
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
              foregroundColor:
                  MaterialStateProperty.all<Color>(CustomStyle.colorPalette[4]),
              backgroundColor: MaterialStateProperty.all<Color>(
                  CustomStyle.colorPalette[1]))));
}
