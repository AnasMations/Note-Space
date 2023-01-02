// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:notespace_home_screen/note_card.dart';

class NoteScrollView extends StatelessWidget {
  const NoteScrollView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
        ),
        children: [
          NoteCard(),
          NoteCard(),
          NoteCard(),
          NoteCard(),
          NoteCard(),
          NoteCard(),
          NoteCard(),
          NoteCard(),
          NoteCard(),
          NoteCard(),
        ],
      ),
    );
  }
}
