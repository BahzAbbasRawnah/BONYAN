import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app/app.dart';
import 'firebase_options.dart';
import 'room.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
void main() async {

  // WidgetsFlutterBinding.ensureInitialized();
  // FirebaseApp app = await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  // runApp( Room());
  runApp( MyApp());
}

