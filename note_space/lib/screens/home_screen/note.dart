// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Note extends StatelessWidget {
  const Note({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      child: Stack(children: [
        Positioned(
            child: Material(
                child: Container(
                    height: 240,
                    width: 200,
                    decoration: BoxDecoration(
                        color: Colors.grey[350],
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                          ),
                        ])))),
        Positioned(
            top: 10,
            right: 20,
            left: 20,
            child: Card(
              elevation: 10.0,
              shadowColor: Colors.grey.withOpacity(0.5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              child: Container(
                height: 130,
                width: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/images/Sample_Note.png"))),
              ),
            )),
        Positioned(
          top: 150,
          left: 5,
          right: 5,
          child: SizedBox(
            height: 250,
            width: 180,
            child: Column(
              children: [
                Text(
                  "Chapter 1 Notes",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                RatingBar.builder(
                  itemCount: 5,
                  itemSize: 25.0,
                  initialRating: 2,
                  minRating: 1,
                  allowHalfRating: true,
                  direction: Axis.horizontal,
                  itemBuilder: (context, index) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (value) {
                    print(value);
                  },
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
