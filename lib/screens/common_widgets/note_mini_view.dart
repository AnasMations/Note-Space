import 'package:flut_fire_training/screens/note_expanded_view_screen/note_expanded_view_screen.dart';
import 'package:flut_fire_training/screens/other_user_profile_screen/other_user_profile_screen.dart';
import 'package:flut_fire_training/services/firebase-services.dart';
import 'package:flutter/material.dart';

import '../../models/note_model.dart';
import '../../style/custom_style.dart';

class NoteMiniView extends StatefulWidget {
  NoteMiniView(this._note, {super.key});
  Note _note;

  @override
  State<NoteMiniView> createState() => _NoteMiniViewState();
}

class _NoteMiniViewState extends State<NoteMiniView> {
  @override
  Widget build(BuildContext context) {
    var customWidth = MediaQuery.of(context).size.width * 0.4;
    var customHeight = MediaQuery.of(context).size.height * 0.35;
    var customPadding =
        EdgeInsets.all(MediaQuery.of(context).size.height * 0.013);
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NoteExpandedViewScreen(widget._note),
            )).then(((value) {
          if (this.mounted) {
            setState(() {});
          }
        }));
      },
      child: Column(
        children: [
          Material(
            elevation: 6,
            shadowColor: Colors.grey.shade300,
            borderRadius: BorderRadius.all(Radius.circular(40)),
            child: Container(
              padding: customPadding,
              height: customHeight,
              width: customWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey.shade200,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                      flex: 16,
                      fit: FlexFit.loose,
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(widget._note.coverImageUrl)),
                        ),
                      )),
                  Flexible(flex: 1, child: Text('')),
                  Flexible(
                      flex: 2,
                      child: Text(widget._note.name,
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold,
                            fontSize: CustomStyle.subAverageSize,
                          ))),
                  Flexible(
                      flex: 2,
                      child: Text(widget._note.category,
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: CustomStyle.subAverageSize,
                          ))),
                  Flexible(
                      flex: 2,
                      child: FutureBuilder(
                          future: FirestoreServices.fetchUser(
                              widget._note.uploaderUID),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return Text(snapshot.data!.name,
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.bold,
                                    fontSize: CustomStyle.averageSize,
                                  ));
                            }
                            return const Center(
                                child: CircularProgressIndicator());
                          })),
                ],
              ),
            ),
          ),
          Container(
            padding: customPadding,
            width: customWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${widget._note.viewCount} views',
                  style: TextStyle(fontSize: CustomStyle.miniSize),
                ),
                Row(
                  children: [
                    Text(
                      '${widget._note.rating} ',
                      style: TextStyle(fontSize: CustomStyle.miniSize),
                    ),
                    Icon(
                      Icons.thumb_up_sharp,
                      color: CustomStyle.colorPalette[2],
                      size: CustomStyle.subAverageSize,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
