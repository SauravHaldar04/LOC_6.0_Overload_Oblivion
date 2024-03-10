import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loc_6_overload_oblivion/staff_profile.dart';

class AdminHomepage extends StatefulWidget {
  @override
  _AdminHomepageState createState() => _AdminHomepageState();
}

class _AdminHomepageState extends State<AdminHomepage> {
  List<String> staffProfiles = ['John Doe', "Jane Smith", "Mike Johnson"];
  List<String> dummyList = [
    'Item 1',
    'Item 2',
    'Item 3',
  ];
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
          StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('staff').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserProfile(
                                uid:
                                    snapshot.data!.docs.elementAt(index)['uid'],
                                name: staffProfiles[index],
                                staffId: snapshot.data!.docs
                                    .elementAt(index)['staffid'],
                                age: "25",
                                performanceImages: dummyList,
                                performanceSummaries: dummyList),
                          ),
                        );
                      },
                      child: StaffProfileCard(
                        staffId:
                            snapshot.data!.docs.elementAt(index)['staffid'],
                      ),
                    );
                  },
                );
              })
        ],
      ),
    );
  }
}

class StaffProfile {
  final String name;
  final String staffID;
  StaffProfile({required this.name, required this.staffID});
}

class StaffProfileCard extends StatelessWidget {
  final String staffId;

  StaffProfileCard({required this.staffId});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Card(
        child: ListTile(
          leading: Icon(
            Icons.person_2_sharp,
            size: 40, // Adjust the icon size as desired
          ),
          title: Text(
            "Staff-ID: ${staffId}",
            style: TextStyle(
              fontSize: 20, // Adjust the staffId font size as desired
            ),
          ),
        ),
      ),
    );
  }
}

class AnotherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Another Page'),
      ),
      body: Center(
        child: Text('This is another page'),
      ),
    );
  }
}
