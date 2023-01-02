// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:notespace_home_screen/note_scroll_view.dart';
import 'package:notespace_home_screen/bottom_navigation_bar.dart';
import 'package:notespace_home_screen/categories_list_title.dart';
import 'package:notespace_home_screen/category_list.dart';
import 'package:notespace_home_screen/most_popular.dart';
import 'package:notespace_home_screen/search_field.dart';
import 'package:notespace_home_screen/title.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //child 1
          SizedBox(height: 40),

          //child 2
          HomeScreenTitle(),

          //child 3
          SizedBox(height: 20),

          //child 4
          SearchField(),

          //child 5
          SizedBox(height: 20),

          //child 6

          CategoryListTitle(),

          //child 7

          SizedBox(height: 10),

          //child 8
          CategoryList(),

          SizedBox(height: 10),

          //child 9
          MostPopular(),

          //child 10
          SizedBox(height: 10),

          //child 11
          NoteScrollView(),

          //child 12
          BottomNavBar(),
        ],
      ),
    );
  }
}
