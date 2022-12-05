// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class MostPopular extends StatelessWidget {
  const MostPopular({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
          child: Text("Most Popular",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        ),
        OutlinedButton(
            style: OutlinedButton.styleFrom(
                side: BorderSide(
              color: Colors.transparent,
            )),
            onPressed: () {
              debugPrint("Recieved Click");
            },
            child:
                Image(image: AssetImage("lib/assets/Rating_System_Icon.png"))),
      ],
    );
  }
}
