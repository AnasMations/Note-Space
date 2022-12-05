import 'package:flut_fire_training/style/custom_style.dart';
import 'package:flutter/material.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Note Space',
          style: TextStyle(
              color: CustomStyle.colorPalette[2],
              fontSize: CustomStyle.massiveTitleSize,
              fontWeight: FontWeight.bold),
        ),
        Text(
          ' All the notes you need',
          style: TextStyle(
            color: CustomStyle.colorPalette[3],
            fontSize: CustomStyle.averageSize,
          ),
        )
      ],
    );
  }
}
