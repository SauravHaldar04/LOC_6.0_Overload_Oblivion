import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loc_6_overload_oblivion/firebase_options.dart';
import 'package:loc_6_overload_oblivion/provider/staff_provider.dart';
import 'package:loc_6_overload_oblivion/splash_screen.dart';
import 'package:loc_6_overload_oblivion/staff_login.dart';
import 'package:loc_6_overload_oblivion/user_type_selection.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => StaffProvider())],
      child: MaterialApp(theme: ThemeData.dark(), home: SplashScreen()));
  }
}
