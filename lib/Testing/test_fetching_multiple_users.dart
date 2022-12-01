import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/firebase-services.dart';

class TestFetchingMultipleUsers extends StatefulWidget {
  TestFetchingMultipleUsers({
    Key? key,
  }) : super(key: key);

  @override
  State<TestFetchingMultipleUsers> createState() =>
      _TestFetchingMultipleUsersState();
}

class _TestFetchingMultipleUsersState extends State<TestFetchingMultipleUsers> {
  bool fetchingData = false;
  Future<List<User?>> futureUserList =
      FirestoreServices.fetchAllUsersByrating(4);
  final loadedUserList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Testing fetching users')),

      //future builder
      body: FutureBuilder(
        future: futureUserList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              //error
              return const Center(child: Text('An error has occured'));
            } else if (snapshot.hasData) {
              //normal
              loadedUserList.addAll(snapshot.data!);
              fetchingData = false;
              return ListView.builder(
                itemCount: loadedUserList.length + 1,
                itemBuilder: ((context, index) {
                  if (index < loadedUserList.length) {
                    return ListTile(
                      title: Text('${loadedUserList[index]!.uID}'),
                      trailing: Text('${loadedUserList[index]!.totalRating}'),
                    );
                  } else {
                    return ListTile(
                      onTap: () {
                        setState(() {
                          futureUserList =
                              FirestoreServices.fetchAllUsersByrating(5,
                                  lastUser: loadedUserList[index - 1]);
                        });
                      },
                      title: Text('Load more'),
                    );
                  }
                }),
              );
            }
          }
          //while loading
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  void updateLoadedUserList(AsyncSnapshot<List<User?>> snapshot) {
    return setState(() {
      loadedUserList.addAll(snapshot.data!);
    });
  }
}
