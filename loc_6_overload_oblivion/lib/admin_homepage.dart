import 'package:flutter/material.dart';
import 'package:loc_6_overload_oblivion/staff_profile.dart';

class AdminHomepage extends StatefulWidget {
  @override
  _AdminHomepageState createState() => _AdminHomepageState();
}

class _AdminHomepageState extends State<AdminHomepage> {
  
  List<StaffProfile> staffProfiles = [
    StaffProfile(name: 'John Doe', staffId: '001'),
    StaffProfile(name: 'Jane Smith', staffId: '002'),
    StaffProfile(name: 'Mike Johnson', staffId: '003'),
  ];
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
          ListView.builder(
            itemCount: staffProfiles.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserProfile(staffProfile: staffProfiles[index], age: "18", performanceImages: dummyList, performanceSummaries: dummyList),
                    ),
                  );
                },
                child: StaffProfileCard(
                  staffId: staffProfiles[index].staffId,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class StaffProfile {
  final String name;
  final String staffId;

  StaffProfile({required this.name, required this.staffId});
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