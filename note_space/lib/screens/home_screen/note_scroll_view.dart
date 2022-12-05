// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flut_fire_training/screens/home_screen/note_card.dart';
import 'package:flutter/material.dart';

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
