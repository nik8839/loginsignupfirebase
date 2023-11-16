import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_signup_firebase/pages/auth_page.dart';
import 'package:login_signup_firebase/pages/home_page.dart';
import 'package:login_signup_firebase/pages/login_page.dart';
import 'package:login_signup_firebase/pages/login_signup.dart';
import 'package:login_signup_firebase/pages/sign_up.dart';

import 'firebase_options.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      ),
      home: //HomePage()
      AuthPage()
    );
  }
}


