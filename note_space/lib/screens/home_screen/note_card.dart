// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flut_fire_training/screens/home_screen/note.dart';
import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        debugPrint("Recieved Click");
      },
      style: OutlinedButton.styleFrom(
          side: BorderSide(
        color: Colors.transparent,
      )),
      child: Note(),
    );
  }
}
