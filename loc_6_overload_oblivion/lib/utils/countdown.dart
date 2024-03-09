import 'package:flutter/material.dart';
import 'package:timer_count_down/timer_count_down.dart';

class countdown extends StatefulWidget {
  const countdown({super.key});

  @override
  State<countdown> createState() => _countdownState();
}

class _countdownState extends State<countdown> {
  @override
  Widget build(BuildContext context) {
    return Countdown(seconds: 20,
      build: (BuildContext context, double time) => Text(time.toString()),
      interval: Duration(hours: 10),
      onFinished: () {
        print('Timer is done!');
      },);
  }
}