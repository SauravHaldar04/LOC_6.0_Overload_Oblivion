import 'dart:async';

import 'package:flutter/material.dart';

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
  _RoomCardState createState() => _RoomCardState();
}

class _RoomCardState extends State<RoomCard> {
  late Timer _timer;
  late Duration _countdownDuration;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startCountdown() {
    final now = DateTime.now();
    if (now.isBefore(widget.checkOutTime)) {
      _countdownDuration = widget.checkOutTime.difference(now);
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          if (_countdownDuration.inSeconds > 0) {
            _countdownDuration = _countdownDuration - Duration(seconds: 1);
          } else {
            _timer.cancel();
          }
        });
      });
    }
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
            'Check-In Time: ${widget.checkInTime}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Check-Out Time: ${widget.checkOutTime}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 10),
          if (_countdownDuration.inSeconds > 0)
            Text(
              'Time Remaining: ${_countdownDuration.inHours}:${_countdownDuration.inMinutes.remainder(60)}:${_countdownDuration.inSeconds.remainder(60)}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
        ],
      ),
    );
  }
}

class StaffRoomPage extends StatefulWidget {
  const StaffRoomPage({Key? key}) : super(key: key);

  @override
  State<StaffRoomPage> createState() => _StaffRoomPageState();
}

class _StaffRoomPageState extends State<StaffRoomPage> {
  List<RoomCard> _roomCards = [
    RoomCard(
      roomNo: '101',
      checkInTime: DateTime(2022, 12, 1, 10, 0), // Replace with actual check-in time
      checkOutTime: DateTime(2022, 12, 1, 12, 0), // Replace with actual check-out time
    ),
    RoomCard(
      roomNo: '102',
      checkInTime: DateTime(2022, 12, 1, 14, 0), // Replace with actual check-in time
      checkOutTime: DateTime(2022, 12, 1, 16, 0), // Replace with actual check-out time
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
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: _roomCards.length,
                  itemBuilder: (context, index) {
                    return _roomCards[index];
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}