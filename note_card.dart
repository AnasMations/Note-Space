// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:notespace_home_screen/note.dart';

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
