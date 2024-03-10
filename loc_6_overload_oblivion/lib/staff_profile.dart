import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loc_6_overload_oblivion/firebase_options.dart';
import 'package:loc_6_overload_oblivion/splash_screen.dart';
import 'package:loc_6_overload_oblivion/admin_homepage.dart';

class UserProfile extends StatelessWidget {
  final String name;
  final String staffId;
  final String age;
  final List<String> performanceImages;
  final List<String> performanceSummaries;

  UserProfile({
    required this.staffId,
    required this.name,
    required this.age,
    required this.performanceImages,
    required this.performanceSummaries,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/Image2.png', // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 70),
              Center(
                child: Icon(
                  Icons.person,
                  size: 80,
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  'Name: ${name}',
                  style: TextStyle(fontSize: 24),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  'Staff-ID: ${staffId}',
                  style: TextStyle(fontSize: 24),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  'Age: $age',
                  style: TextStyle(fontSize: 24),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  'Performance Report',
                  style: TextStyle(fontSize: 24),
                ),
              ),
              SizedBox(height: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  PerformanceSection(
                    image: performanceImages[0],
                    summary: performanceSummaries[0],
                  ),
                  PerformanceSection(
                    image: performanceImages[1],
                    summary: performanceSummaries[1],
                  ),
                  PerformanceSection(
                    image: performanceImages[2],
                    summary: performanceSummaries[2],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PerformanceSection extends StatelessWidget {
  final String image;
  final String summary;

  PerformanceSection({
    required this.image,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          image,
          width: 120,
          height: 120,
          fit: BoxFit.cover,
        ),
        SizedBox(height: 10),
        Text(
          summary,
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
