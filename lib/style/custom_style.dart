import 'dart:ffi';

import 'package:flutter/material.dart';

class CustomStyle {
  static List<Color> colorPalette = [
    const Color.fromARGB(255, 117, 79, 68),
    const Color.fromARGB(255, 247, 130, 84),
    Colors.amber,
    const Color.fromARGB(240, 151, 171, 177),
    const Color.fromARGB(255, 255, 255, 255),
    Colors.black54,
    Colors.amber.shade200,
    Colors.grey.shade300,
  ];

  static double massiveTitleSize = 60.0;
  static double subMassiveTitleSize = 30.0;
  static double averageSize = 18.0;
  static double subAverageSize = 15.0;
  static double miniSize = 10.0;

  //button themes

  //text buttons
  static final customTextButtonTheme = TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor:
          MaterialStateProperty.all<Color>(CustomStyle.colorPalette[4]),
    ),
  );
  //outlined buttons
  static final customOutlinedButtonTheme = OutlinedButtonThemeData(
      style: ButtonStyle(
          foregroundColor:
              MaterialStateProperty.all<Color>(CustomStyle.colorPalette[4]),
          backgroundColor:
              MaterialStateProperty.all<Color>(CustomStyle.colorPalette[1])));
  //elevated buttons
  static final customElevatedButtonTheme = ElevatedButtonThemeData(
      style: ButtonStyle(
          foregroundColor:
              MaterialStateProperty.all<Color>(CustomStyle.colorPalette[4]),
          backgroundColor:
              MaterialStateProperty.all<Color>(CustomStyle.colorPalette[1])));
  //input decoration
  static final customInputDecoration = InputDecorationTheme(
      fillColor: colorPalette[6],
      filled: true,
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorPalette[1]),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))));
  //
  //*************************************** */

  //rounded edge orange box decoration
  static BoxDecoration customBoxDecoration(bool tophalf, bool bottomHalf,
      {Color? color, double? boxRadius}) {
    (color == null) ? color = CustomStyle.colorPalette[2] : color = color;
    late double radius;
    (boxRadius == null) ? radius = 40.0 : radius = boxRadius;

    if (tophalf && !bottomHalf) {
      return BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radius),
              topRight: Radius.circular(radius)),
          color: color);
    } else if (bottomHalf && !tophalf) {
      return BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(radius),
              bottomRight: Radius.circular(radius)),
          color: color);
    } else if (bottomHalf && tophalf) {
      return BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          color: color);
    } else {
      return BoxDecoration(color: color);
    }
  }
}
