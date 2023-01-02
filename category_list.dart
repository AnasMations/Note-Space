// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
      child: Row(
        children: [
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 242, 193, 78),
              shape: StadiumBorder(),
            ),
            onPressed: () {
              debugPrint('Received click');
            },
            child: const Text(
              'Computer Science',
              style: TextStyle(color: Colors.black),
            ),
          ),
          SizedBox(width: 5.0),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 242, 193, 78),
              shape: StadiumBorder(),
            ),
            onPressed: () {
              debugPrint('Received click');
            },
            child: const Text(
              'Engineering',
              style: TextStyle(color: Colors.black),
            ),
          ),
          SizedBox(width: 5.0),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 242, 193, 78),
              shape: StadiumBorder(),
            ),
            onPressed: () {
              debugPrint('Received click');
            },
            child: const Text(
              'Business',
              style: TextStyle(color: Colors.black),
            ),
          ),
          SizedBox(width: 5.0),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 242, 193, 78),
              shape: StadiumBorder(),
            ),
            onPressed: () {
              debugPrint('Received click');
            },
            child: const Text(
              'Biotechnology',
              style: TextStyle(color: Colors.black),
            ),
          )
        ],
      ),
    );
  }
}
