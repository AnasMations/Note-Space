// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class HomeScreenTitle extends StatelessWidget {
  const HomeScreenTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          RichText(
              text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                TextSpan(
                    text: "Note Space",
                    style: TextStyle(
                      color: Color.fromARGB(255, 242, 193, 78),
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                    )),
                TextSpan(
                    text: "\nAll the notes you need",
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Color.fromARGB(240, 151, 171, 177),
                      fontSize: 18,
                    ))
              ]))
        ],
      ),
    );
  }
}
