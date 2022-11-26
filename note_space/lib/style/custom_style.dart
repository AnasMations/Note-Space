import 'package:flutter/material.dart';

class CustomStyle {
  static List<Color> colorPalette = [
    const Color.fromARGB(255, 117, 79, 68),
    const Color.fromARGB(255, 247, 130, 84),
    Colors.amber,
    const Color.fromARGB(255, 151, 171, 177),
    const Color.fromARGB(255, 255, 255, 255),
    Colors.black54,
    Colors.amber.shade200,
  ];

  static double massiveTitleSize = 60.0;
  static double subMassiveTitleSize = 45.0;
  static double averageSize = 25.0;
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
      floatingLabelBehavior: FloatingLabelBehavior.never,
      border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))));
  //
  //*************************************** */

  //rounded edge orange box decoration
  static BoxDecoration customBoxDecoration(bool tophalf, bool bottomHalf) {
    if (tophalf && !bottomHalf) {
      return BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40)),
          color: CustomStyle.colorPalette[2]);
    } else if (bottomHalf && !tophalf) {
      return BoxDecoration(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40)),
          color: CustomStyle.colorPalette[2]);
    } else if (bottomHalf && tophalf) {
      return BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(40)),
          color: CustomStyle.colorPalette[2]);
    } else {
      return BoxDecoration(color: CustomStyle.colorPalette[2]);
    }
  }
}
