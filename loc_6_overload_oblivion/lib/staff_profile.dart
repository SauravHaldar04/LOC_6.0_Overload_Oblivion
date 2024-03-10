import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loc_6_overload_oblivion/firebase_options.dart';
import 'package:loc_6_overload_oblivion/splash_screen.dart';
import 'package:loc_6_overload_oblivion/admin_homepage.dart';

class UserProfile extends StatefulWidget {
  final String uid;
  final String name;
  final String staffId;
  final String age;
  final List<String> performanceImages;
  final List<String> performanceSummaries;

  UserProfile({
    required this.uid,
    required this.staffId,
    required this.name,
    required this.age,
    required this.performanceImages,
    required this.performanceSummaries,
  });

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  Map<String, dynamic>? staffData;

  @override
  void initState() {
    super.initState();
    getStaffData();
  }

  Future<void> getStaffData() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('staff')
          .doc(widget.uid)
          .get();
      setState(() {
        staffData = snapshot.data() as Map<String, dynamic>?;
      });
    } catch (e) {
      print('Error getting staff data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 15),
            Icon(
              Icons.person,
              size: 80,
            ),
            SizedBox(height: 10),
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Text(
                    'Name: ${widget.name}',
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Staff-ID: ${widget.staffId}',
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Age: ${widget.age}',
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Performance Report',
                    style: TextStyle(fontSize: 24),
                  ),
                  if (staffData != null) ...[
                    Text(
                      staffData!['cleanStartTime'].toString(),
                      style: TextStyle(fontSize: 24),
                    ),
                    SizedBox(height: 20),
                    Text(
                      staffData!['cleanEndTime'].toString(),
                      style: TextStyle(fontSize: 24),
                    ),
                  ],

                  SizedBox(height: 10),
                  // StreamBuilder(
                  //   stream: FirebaseFirestore.instance
                  //       .collection('staff')
                  //       .where('uid', isEqualTo: widget.uid)
                  //       .snapshots(),
                  //   builder: (context, snapshot) {
                  //     if (snapshot.hasError) {
                  //       return Text('Error: ${snapshot.error}');
                  //     }

                  //     if (snapshot.connectionState ==
                  //         ConnectionState.waiting) {
                  //       return Center(child: CircularProgressIndicator());
                  //     }

                  //     final staffData =
                  //         snapshot.data! as Map<String, dynamic>;
                  //     if (staffData == null) return Text('No data found');

                  //     // Assuming 'schedule' is the subcollection name
                  //     final List<String> imageUrls = [];
                  //     if (staffData['schedule'] as Map<String, dynamic> !=
                  //         null) {
                  //       for (var scheduleItem in staffData['schedule']) {
                  //         if (scheduleItem['imageUrl'] != null) {
                  //           imageUrls.add(scheduleItem['imageUrl']);
                  //         }
                  //         if (scheduleItem['checkOutImage'] != null) {
                  //           imageUrls.add(scheduleItem['checkOutImage']);
                  //         }
                  //         if (scheduleItem['cleanUpImage'] != null) {
                  //           imageUrls.add(scheduleItem['cleanUpImage']);
                  //         }
                  //       }
                  //     }

                  //     // Replace the empty itemCount and itemBuilder with your logic
                  //     return ListView.builder(
                  //       itemCount: imageUrls.length,
                  //       itemBuilder: (context,
                  //               index) => // Your widget to display the image
                  //           Image.network(imageUrls[index]),
                  //     );
                  //   },
                  // )
                ],
              ),
            ),
          ],
        ),
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
