import 'package:flut_fire_training/style/custom_style.dart';
import 'package:flutter/material.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({
    Key? key,
  }) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Center(
                child: Text(
              'Update profile',
              style: TextStyle(
                  color: CustomStyle.colorPalette[2],
                  fontSize: CustomStyle.massiveTitleSize,
                  fontWeight: FontWeight.bold),
            )),
          ),
          Expanded(
              flex: 8,
              child: Container(
                decoration: CustomStyle.customBoxDecoration(true, false),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 6,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: []),
                      )
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
