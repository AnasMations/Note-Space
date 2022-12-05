import 'package:flutter/material.dart';

import '../../models/user_model.dart';
import '../../style/custom_style.dart';

class UserProfileCard extends StatelessWidget {
  const UserProfileCard({
    Key? key,
    required this.mainUser,
  }) : super(key: key);

  final User mainUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.54,
      width: MediaQuery.of(context).size.width * 0.77,
      decoration: CustomStyle.customBoxDecoration(true, true,
          color: CustomStyle.colorPalette[6]),
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.08),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
              flex: 4,
              child: CircleAvatar(
                radius: MediaQuery.of(context).size.width * 0.24,
                foregroundImage: NetworkImage(mainUser.coverImageUrl),
                foregroundColor: CustomStyle.colorPalette[2],
              ),
            ),
            Flexible(
              flex: 1,
              child: Text(
                '${mainUser.name}',
                style: TextStyle(
                    fontSize: CustomStyle.subMassiveTitleSize,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Flexible(
              flex: 1,
              child: Text(
                '${mainUser.university}',
                style: TextStyle(
                    fontSize: CustomStyle.averageSize,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Flexible(
              flex: 2,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Text(
                  '${mainUser.userDescription}',
                  style: TextStyle(
                    fontSize: CustomStyle.subAverageSize,
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${mainUser.totalRating}  ',
                    style: TextStyle(fontSize: CustomStyle.subAverageSize),
                  ),
                  Icon(
                    Icons.thumb_up_sharp,
                    color: CustomStyle.colorPalette[2],
                    size: CustomStyle.subAverageSize,
                  )
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Text(
                '${mainUser.downloadCount} Downloads  ${mainUser.downloadCount} Views',
                style: TextStyle(
                  fontSize: CustomStyle.subAverageSize,
                ),
              ),
            ),
          ]),
    );
  }
}
