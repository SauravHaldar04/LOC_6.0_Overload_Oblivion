import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:loc_6_overload_oblivion/user_type_selection.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(splash: Column(
      children: [
        Center(
          child: LottieBuilder.asset("assets/Lottie/Animation1.json")
        )
      ],
    ), nextScreen: const UserTypeSelectionState(),
    splashIconSize: 430,
        backgroundColor: Color.fromRGBO(8, 17, 40, 1));
   
  }
}