import 'dart:async';

import 'package:flutter/material.dart';
import 'package:slide_countdown/slide_countdown.dart';

class RoomCard extends StatefulWidget {
  final String roomNo;
  final DateTime checkInTime;
  final DateTime checkOutTime;
 

  const RoomCard({
    Key? key,
    required this.roomNo,
    required this.checkInTime,
    required this.checkOutTime,
    
  }) : super(key: key);

  @override
  State<RoomCard> createState() => _RoomCardState();
}

class _RoomCardState extends State<RoomCard> {
  Duration? duration;

  @override
  void initState() {
    super.initState();
    duration = widget.checkOutTime.difference(widget.checkInTime);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width - 50,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 58, 58, 58),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Room No: ${widget.roomNo}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Check-In Date: ${widget.checkInTime.toLocal()}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Check-Out Date: ${widget.checkOutTime.toLocal()}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 10),
          // if (duration != null)
          //   Text(
          //     'Duration: ${duration!.inMilliseconds.toString()} milliseconds',
          //     style: TextStyle(
          //       color: Colors.white,
          //       fontSize: 16,
          //     ),
          //   ),
          SlideCountdown( duration: duration),

        ],
      ),
    );
  }
}

class StaffRoomPage extends StatefulWidget {
  @override
  State<StaffRoomPage> createState() => _StaffRoomPageState();
}

class _StaffRoomPageState extends State<StaffRoomPage> {
  List<RoomCard> _roomCards = [
    RoomCard(
      roomNo: '101',
      checkInTime: DateTime(2022, 12, 1, 10, 0), // Replace with actual check-in time
      checkOutTime: DateTime(2022, 12, 1, 12, 0),
       // Replace with actual check-out time
    ),
    RoomCard(
      roomNo: '102',
      checkInTime: DateTime(2022, 12, 1, 14, 0), // Replace with actual check-in time
      checkOutTime: DateTime(2022, 12, 1, 16, 0),
      // Replace with actual check-out time
    ),
    // Add more room cards as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/Image1.png', // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            left: 10,
            top: 25,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          Positioned(
            top: 100,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome Staff',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 400,
                  width: 380,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _roomCards.length,
                    itemBuilder: (context, index) {
                      return _roomCards[index];
                    },
                  ),
                ),
               
              ],
            ),
          ),
        ],
      ),
    );
  }
}