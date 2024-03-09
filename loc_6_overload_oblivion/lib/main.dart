import 'package:flutter/material.dart';
import 'package:loc_6_overload_oblivion/staff_login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:LoginPage()
    );
  }
}
