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
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Row(
        children: [
          SizedBox(
            width: 95,
          ),
          Column(
            children: [
              SizedBox(height: 15),
              Icon(
                Icons.person,
                size: 80,
              ),
              SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text(
                        'Name: ${name}',
                        style: TextStyle(fontSize: 24),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Staff-ID: ${staffId}',
                        style: TextStyle(fontSize: 24),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Age: $age',
                        style: TextStyle(fontSize: 24),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Performance Report',
                        style: TextStyle(fontSize: 24),
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
                ),
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
