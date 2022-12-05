import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flut_fire_training/providers/user_provider.dart';
import 'package:flut_fire_training/services/firebase-services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //initialize firebase and downloader package
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseUIAuth.configureProviders([EmailAuthProvider()]);
  final mainUser = await FirestoreServices.fetchUser('lVesg6LXuoW1sly2Wd8D');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(mainUser!),
        ),
      ],
      child: MyApp(),
    ),
  );
}
