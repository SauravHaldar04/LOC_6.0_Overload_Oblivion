import 'package:flutter/material.dart';
import 'package:loc_6_overload_oblivion/AI_image.dart';
import 'package:loc_6_overload_oblivion/admin_homepage.dart';
import 'package:loc_6_overload_oblivion/analysis.dart';
import 'package:loc_6_overload_oblivion/staff_roompage.dart';

class AdminBottombar extends StatefulWidget {
  const AdminBottombar({Key? key}) : super(key: key);

  @override
  State<AdminBottombar> createState() => _AdminBottombarState();
}

class _AdminBottombarState extends State<AdminBottombar> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    AdminHomepage(),
    Analysis(),
    MyApp2(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromRGBO(8, 17, 40, 1),
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Analysis',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'AI_Image_Generation',
          ),
        ],
      ),
    );
  }
}
