import 'package:flut_fire_training/screens/common_widgets/note_mini_view.dart';
import 'package:flut_fire_training/screens/user_profile_screen/main_user_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/note_model.dart';
import '../../models/user_model.dart';
import '../../providers/user_provider.dart';
import '../../services/firebase-services.dart';
import '../../style/custom_style.dart';
import '../common_widgets/app_title.dart';
import '../common_widgets/bottom_navigation_bar.dart';
import '../other_user_profile_screen/other_user_profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  String defaultCat = "General";

  @override
  Widget build(BuildContext context) {
    //connect this variable to provider
    Future<List<Note>> fetchedNotes =
        FirestoreServices.fetchAllNotesUnderCategoryByrating(10, defaultCat);

    return Scaffold(
      bottomNavigationBar: const CustomBottomNavBar(0),
      // resizeToAvoidBottomInset: false,
      // appBar: AppBar(title: const Text('Testing fetching users')),
      body: Padding(
        padding: EdgeInsets.fromLTRB(
            MediaQuery.of(context).size.width * 0.05,
            MediaQuery.of(context).size.height * 0.02,
            MediaQuery.of(context).size.width * 0.05,
            MediaQuery.of(context).size.height * 0.01),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            //upper white area of log in screen and title
            const Flexible(
              flex: 2,
              child: AppTitle(),
            ),
            Flexible(
              flex: 1,
              child: Text('Categories',
                  style: TextStyle(
                      fontSize: CustomStyle.averageSize,
                      fontWeight: FontWeight.bold)),
            ),

            //orange area with log in form
            Flexible(
              flex: 1,
              child: FutureBuilder(
                future: FirestoreServices.fetchCategories(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    List<Widget> cats = [];
                    for (String cat in snapshot.data!) {
                      final temp = Padding(
                        padding: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * 0,
                          MediaQuery.of(context).size.height * 0.01,
                          MediaQuery.of(context).size.width * 0.05,
                          MediaQuery.of(context).size.height * 0.01,
                        ),
                        child: OutlinedButton(
                          style: (defaultCat.trim().toLowerCase() !=
                                  cat.trim().toLowerCase())
                              ? ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          CustomStyle.colorPalette[2]),
                                )
                              : ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          CustomStyle.colorPalette[1])),
                          onPressed: () {
                            setState(() {
                              defaultCat = cat;
                              fetchedNotes = FirestoreServices
                                  .fetchAllNotesUnderCategoryByrating(10, cat);
                            });
                          },
                          child: Text('$cat'),
                        ),
                      );
                      if ((defaultCat.trim().toLowerCase() !=
                          cat.trim().toLowerCase()))
                        cats.add(temp);
                      else
                        cats.insert(0, temp);
                    }
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: cats,
                      ),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            Flexible(
                flex: 8,
                child: FutureBuilder(
                  future: fetchedNotes,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        print(snapshot.data);

                        return GridView.builder(
                            itemCount: snapshot.data!.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisExtent:
                                  MediaQuery.of(context).size.height * 0.45,
                            ),
                            itemBuilder: ((context, index) =>
                                NoteMiniView(snapshot.data![index])));
                      }
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                )),
          ],
        ),
      ),
    );
  }
}
