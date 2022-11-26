import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flut_fire_training/models/user_model.dart';
import 'package:flut_fire_training/services/firebase-services.dart';
import 'package:flut_fire_training/style/custom_style.dart';
import 'package:flutter/material.dart';

class UpdateProfile extends StatelessWidget {
  const UpdateProfile({
    this.currentUser,
    Key? key,
  }) : super(key: key);
  final User? currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
          Expanded(flex: 8, child: UpdateUserInfoForm(currentUser: currentUser))
        ],
      ),
    );
  }
}

class UpdateUserInfoForm extends StatefulWidget {
  const UpdateUserInfoForm({super.key, this.currentUser});
  final User? currentUser;
  @override
  State<UpdateUserInfoForm> createState() => _UpdateUserInfoFormState();
}

class _UpdateUserInfoFormState extends State<UpdateUserInfoForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    CircleAvatar userProfilePic = CircleAvatar(
      foregroundColor: CustomStyle.colorPalette[1],
      backgroundColor: CustomStyle.colorPalette[1],
      backgroundImage:
          const AssetImage('lib/assets/images/defaultProfilePic.jpg'),
      foregroundImage: (widget.currentUser?.coverImageUrl != null)
          ? NetworkImage('${widget.currentUser!.coverImageUrl}')
          : null,
      radius: 60,
    );

    String userName =
        (widget.currentUser?.name != null) ? '${widget.currentUser!.name}' : "";
    String university = (widget.currentUser?.university != null)
        ? '${widget.currentUser!.university}'
        : "";
    String userDescription = (widget.currentUser?.userDescription != null)
        ? '${widget.currentUser!.userDescription}'
        : "";
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: CustomStyle.customBoxDecoration(false, false),
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //user profile pic , wrapping it with row prevent it from stretching
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    userProfilePic,
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.add_box_rounded,
                          color: CustomStyle.colorPalette[1],
                        ))
                  ],
                ),
                //name
                TextFormField(
                  initialValue: userName,
                  decoration: InputDecoration(
                    label: Text('Name'),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    } else {
                      userName = value;
                    }
                    return null;
                  },
                ),
                //university
                TextFormField(
                  initialValue: university,
                  decoration: const InputDecoration(label: Text('University')),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your University';
                    } else {
                      university = value;
                    }
                    return null;
                  },
                ),
                //Description
                TextFormField(
                  initialValue: userDescription,
                  decoration: const InputDecoration(label: Text('About')),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please tell us about yourself';
                    } else {
                      userDescription = value;
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Updating information')),
                        );
                        User currentUser = User(
                            name: userName,
                            uID: await auth
                                .FirebaseAuth.instance.currentUser!.uid,
                            university: university,
                            coverImageUrl: "",
                            totalRating: 0,
                            userDescription: userDescription);
                        await FirestoreServices.createUser(currentUser);
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: ((context) => Scaffold())));
                      }
                    },
                    child: Text('Update'))
              ]),
        ),
      ),
    );
  }
}
