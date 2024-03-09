import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loc_6_overload_oblivion/firebase_options.dart';
import 'package:loc_6_overload_oblivion/staff_login.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:LoginPage()
    );
=======
    return MaterialApp(home: LoginPage());
>>>>>>> 99f3bcb0bb696c97e58a8905191d797b3b52e82c
  }
}
