import 'package:flutter/material.dart';
import 'package:loc_6_overload_oblivion/admin_login.dart';
import 'package:loc_6_overload_oblivion/staff_login.dart';

class UserTypeSelectionState extends StatefulWidget {
  const UserTypeSelectionState({super.key});

  @override
  State<UserTypeSelectionState> createState() => UserTypeSelectionStateState();
}

class UserTypeSelectionStateState extends State<UserTypeSelectionState> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/Image1.png', // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Choose your Role',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const LoginPage2(),
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        Container(
                          height: 170,
                          width: 170,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromRGBO(8, 17, 40, 1),
                          ),
                        ),
                        Positioned.fill(
                          left: 27,
                          top: 27,
                          bottom: 27,
                          right: 27,
                          child: CircleAvatar(
                            radius: 21,
                            backgroundColor: Color.fromRGBO(8, 17, 40, 1),
                            backgroundImage:
                                AssetImage('assets/images/shield_person.png'),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        Container(
                          height: 170,
                          width: 170,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromRGBO(8, 17, 40, 1),
                          ),
                        ),
                        Positioned.fill(
                          left: 27,
                          top: 27,
                          bottom: 27,
                          right: 27,
                          child: CircleAvatar(
                            radius: 3,
                            backgroundColor: Color.fromRGBO(8, 17, 40, 1),
                            backgroundImage:
                                AssetImage('assets/images/person_apron.png'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Admin",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 120),
                  Text(
                    "Staff",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
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
