import 'package:flutter/material.dart';
import 'package:loc_6_overload_oblivion/staff_home_page.dart';
import 'package:loc_6_overload_oblivion/staff_roompage.dart';

class StaffBottombar extends StatefulWidget {
  const StaffBottombar({Key? key}) : super(key: key);

  @override
  State<StaffBottombar> createState() => _StaffBottombarState();
}

class _StaffBottombarState extends State<StaffBottombar> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    StaffHomePage(),
    StaffRoomPage(),
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
        backgroundColor: Colors.black,
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
            icon: Icon(Icons.list),
            label: 'Rooms',
          ),
        ],
      ),
    );
  }
}


