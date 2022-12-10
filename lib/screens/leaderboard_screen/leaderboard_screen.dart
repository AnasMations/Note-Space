import 'package:flut_fire_training/screens/user_profile_screen/main_user_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user_model.dart';
import '../../providers/user_provider.dart';
import '../../services/firebase-services.dart';
import '../../style/custom_style.dart';
import '../common_widgets/app_title.dart';
import '../common_widgets/bottom_navigation_bar.dart';
import '../other_user_profile_screen/other_user_profile_screen.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() {
    return _LeaderboardScreenState();
  }
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  @override
  Widget build(BuildContext context) {
    //connect this variable to provider
    List<User> userList =
        Provider.of<UserProvider>(context).getTempFetchedUsers();
    var fetchingUsers = false;
    var userLoadIntervals = 10;

    if (Provider.of<UserProvider>(context).getTempFetchedUsers().isEmpty) {
      Provider.of<UserProvider>(
        context,
      ).fetchSomeUsersForLeaderBoard(userLoadIntervals);
    }

    return Scaffold(
      bottomNavigationBar: const CustomBottomNavBar(3),
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(title: const Text('Testing fetching users')),
      body: Padding(
        padding: EdgeInsets.fromLTRB(
            MediaQuery.of(context).size.width * 0.05,
            MediaQuery.of(context).size.height * 0.05,
            MediaQuery.of(context).size.width * 0.05,
            MediaQuery.of(context).size.height * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //upper white area of log in screen and title
            const Flexible(
              flex: 2,
              child: AppTitle(),
            ),

            //orange area with log in form
            Flexible(
              flex: 8,
              child: RefreshIndicator(
                onRefresh: () {
                  Provider.of<UserProvider>(context, listen: false)
                      .getTempFetchedUsers()
                      .clear();
                  return Provider.of<UserProvider>(context, listen: false)
                      .fetchSomeUsersForLeaderBoard(userLoadIntervals);
                },
                child: ListView.builder(
                  itemCount: userList.length + 2,
                  itemBuilder: ((context, index) {
                    //leaderBoard title
                    if (index == 0) {
                      return Text(
                        '  LeaderBoard',
                        style: TextStyle(
                            fontSize: CustomStyle.subAverageSize,
                            fontWeight: FontWeight.bold),
                      );
                    } else if (index == userList.length + 1) {
                      return OutlinedButton(
                          onPressed: () {
                            if (!fetchingUsers) {
                              fetchingUsers = true;
                              Provider.of<UserProvider>(context, listen: false)
                                  .fetchSomeUsersForLeaderBoard(
                                      userLoadIntervals);
                            }
                          },
                          child: const Text('Load more'));
                    }

                    //user leaderBoard
                    else {
                      User user = userList[index - 1];

                      return createLeaderboardUserTile(index, user, context);
                    }
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget createLeaderboardUserTile(int index, User user, BuildContext context) {
    return Card(
      color: CustomStyle.colorPalette[7],
      child: ListTile(
        selectedTileColor: CustomStyle.colorPalette[2],
        /*  contentPadding:
            EdgeInsets.symmetric(horizontal: CustomStyle.averageSize / 3), */
        leading: Text('$index',
            style: TextStyle(
              fontSize: CustomStyle.subMassiveTitleSize,
              fontWeight: FontWeight.bold,
            )),
        title: FittedBox(
          alignment: Alignment.centerLeft,
          fit: BoxFit.scaleDown,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            CircleAvatar(
              radius: CustomStyle.averageSize,
              foregroundImage: NetworkImage(user.coverImageUrl),
              foregroundColor: CustomStyle.colorPalette[2],
            ),
            Text(
              ' ${user.name}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: CustomStyle.averageSize,
              ),
            )
          ]),
        ),
        trailing: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${user.downloadCount} Downloads',
                style: TextStyle(
                  fontSize: CustomStyle.miniSize,
                ),
              ),
              Text(
                '${user.viewCount} Views',
                style: TextStyle(fontSize: CustomStyle.miniSize),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${user.totalRating}  ',
                    style: TextStyle(fontSize: CustomStyle.miniSize),
                  ),
                  Icon(
                    Icons.thumb_up_sharp,
                    color: CustomStyle.colorPalette[2],
                    size: CustomStyle.subAverageSize,
                  )
                ],
              ),
            ],
          ),
        ),
        onTap: () {
          if (user.uID ==
              Provider.of<UserProvider>(context, listen: false)
                  .getMainUser()
                  .uID)
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => (MainUserProfileView()),
                ));
          else {
            //open user view profile page for selected user
            Provider.of<UserProvider>(context, listen: false)
                .getTempFetchedUsers()
                .clear();
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => (OtherUserProfileView(user)),
                )).then((value) => setState(
                  () {
                    Provider.of<UserProvider>(context, listen: false)
                        .fetchSomeUsersForLeaderBoard(10);
                  },
                ));
          }
        },
      ),
    );
  }
}
