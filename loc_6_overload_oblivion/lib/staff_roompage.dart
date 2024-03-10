import 'dart:async';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loc_6_overload_oblivion/models/staff_model.dart';
import 'package:loc_6_overload_oblivion/provider/staff_provider.dart';
import 'package:loc_6_overload_oblivion/resources/storage_methods.dart';
import 'package:loc_6_overload_oblivion/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:slide_countdown/slide_countdown.dart';

Uint8List? _file1;
Uint8List? _file2;

class RoomCard extends StatefulWidget {
  final String roomNo;
  final DateTime checkInTime;
  final DateTime checkOutTime;
  final Function onTap;
  final Function oncheckout;
  final Function oncleanup;
  final String status;

  const RoomCard({
    Key? key,
    required this.roomNo,
    required this.checkInTime,
    required this.checkOutTime,
    required this.onTap,
    required this.status,
    required this.oncheckout,
    required this.oncleanup,
  }) : super(key: key);

  @override
  State<RoomCard> createState() => _RoomCardState();
}

class _RoomCardState extends State<RoomCard> {
  Duration? duration;
  bool isCheckout = false;
  bool isCleaning = false;

  @override
  void initState() {
    super.initState();
    duration = widget.checkOutTime.difference(widget.checkInTime);
  }

  @override
  Widget build(BuildContext context) {
    selectImage1(
      BuildContext context,
    ) {
      return showDialog(
          context: context,
          builder: (context) {
            return SimpleDialog(
              title: const Text('Create a post'),
              children: [
                SimpleDialogOption(
                  child: const Text('Take photo'),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    Uint8List file =
                        await pickImage(ImageSource.camera) as Uint8List;
                    setState(() {
                      _file1 = file;
                    });
                  },
                ),
                SimpleDialogOption(
                  child: const Text('Choose from gallery'),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    Uint8List file =
                        await pickImage(ImageSource.gallery) as Uint8List;
                    setState(() {
                      _file1 = file;
                    });
                  },
                ),
                SimpleDialogOption(
                  child: const Text('Cancel'),
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    }

    selectImage2(
      BuildContext context,
    ) {
      return showDialog(
          context: context,
          builder: (context) {
            return SimpleDialog(
              title: const Text('Create a post'),
              children: [
                SimpleDialogOption(
                  child: const Text('Take photo'),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    Uint8List file =
                        await pickImage(ImageSource.camera) as Uint8List;
                    setState(() {
                      _file2 = file;
                    });
                  },
                ),
                SimpleDialogOption(
                  child: const Text('Choose from gallery'),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    Uint8List file =
                        await pickImage(ImageSource.gallery) as Uint8List;
                    setState(() {
                      _file2 = file;
                    });
                  },
                ),
                SimpleDialogOption(
                  child: const Text('Cancel'),
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    }

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Room No: ${widget.roomNo}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SlideCountdown(duration: duration),
            ],
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
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                  onPressed: () {
                    widget.onTap();
                    setState(() {
                      isCheckout = true;
                      print(isCheckout.toString());
                    });
                  },
                  child: Text('Checkout')),
              Text(
                widget.status == 'occupied' ? 'Occupied' : 'Cleaning',
                style: TextStyle(
                  color:
                      widget.status == 'occupied' ? Colors.red : Colors.yellow,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          isCheckout
              ? _file1 == null
                  ? GestureDetector(
                      onTap: () {
                        selectImage1(context);
                      },
                      child: DottedBorder(
                        color: Colors.white,
                        borderType: BorderType.RRect,
                        dashPattern: const [10, 4],
                        radius: const Radius.circular(10),
                        strokeCap: StrokeCap.round,
                        child: Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                const Icon(
                                  Icons.upload,
                                  size: 40,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'Add Room Image After Checkout',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey.shade400),
                                )
                              ]),
                        ),
                      ),
                    )
                  : Column(
                      children: [
                        Container(
                          height: 300,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            image: DecorationImage(
                              image: MemoryImage(_file1!),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            widget.oncheckout();
                            isCleaning = true;
                          },
                          child: const Text('Add Room Image After Checkout'),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        isCleaning
                            ? _file2 == null
                                ? GestureDetector(
                                    onTap: () {
                                      selectImage2(context);
                                    },
                                    child: DottedBorder(
                                      color: Colors.white,
                                      borderType: BorderType.RRect,
                                      dashPattern: const [10, 4],
                                      radius: const Radius.circular(10),
                                      strokeCap: StrokeCap.round,
                                      child: Container(
                                        height: 150,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              const Icon(
                                                Icons.upload,
                                                size: 40,
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Text(
                                                'Add Room Image After Cleaning',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color:
                                                        Colors.grey.shade400),
                                              )
                                            ]),
                                      ),
                                    ),
                                  )
                                : Column(
                                    children: [
                                      Container(
                                        height: 300,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          image: DecorationImage(
                                            image: MemoryImage(_file2!),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          widget.oncleanup();
                                          setState(() {
                                            _file1 = null;
                                          });
                                        },
                                        child: const Text(
                                            'Add Room Image After Cleaning'),
                                      ),
                                    ],
                                  )
                            : Container()
                      ],
                    )
              : Container()

          // if (duration != null)
          //   Text(
          //     'Duration: ${duration!.inMilliseconds.toString()} milliseconds',
          //     style: TextStyle(
          //       color: Colors.white,
          //       fontSize: 16,
          //     ),
          //   ),
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
  @override
  Widget build(BuildContext context) {
    Staff _staff = Provider.of<StaffProvider>(context, listen: false).getUser();
    postImage(String roomNo) async {
      Staff _staff =
          Provider.of<StaffProvider>(context, listen: false).getUser();
      QuerySnapshot scheduleSnapshot = await FirebaseFirestore.instance
          .collection('rooms')
          .doc(roomNo) // Assuming roomNo is the document ID
          .collection('schedule')
          .get();

      if (scheduleSnapshot.docs.isNotEmpty) {
        // Assuming you're only interested in the first schedule document
        String scheduleId = scheduleSnapshot.docs.first['scheduleid'];

        String res = await StorageMethods().postImage2(
          cleanStartTime: DateTime.now(),
          roomNo: int.parse(roomNo),
          image: _file1!,
          scheduleId: scheduleId,
        );

        showSnackBar(context, res);
      } else {
        print('No schedule found for this room');
      }
    }

    postImage2(String roomNo) async {
      Staff _staff =
          Provider.of<StaffProvider>(context, listen: false).getUser();
      QuerySnapshot scheduleSnapshot = await FirebaseFirestore.instance
          .collection('rooms')
          .doc(roomNo) // Assuming roomNo is the document ID
          .collection('schedule')
          .get();

      if (scheduleSnapshot.docs.isNotEmpty) {
        // Assuming you're only interested in the first schedule document
        String scheduleId = scheduleSnapshot.docs.first['scheduleid'];

        String res = await StorageMethods().postImage3(
          cleanEndTime: DateTime.now(),
          roomNo: int.parse(roomNo),
          image: _file2!,
          scheduleId: scheduleId,
        );

        showSnackBar(context, res);
      } else {
        print('No schedule found for this room');
      }
    }

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/Image2.png', // Replace with your image path
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
                  'Room Data',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                    height: MediaQuery.of(context).size.height - 300,
                    width: 380,
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('rooms')
                          .where(
                            'status',
                            whereIn: ['occupied', 'cleaning'],
                          )
                          .where('staffID', isEqualTo: _staff.staffid)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }

                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot room =
                                  snapshot.data!.docs[index];

                              return RoomCard(
                                  oncleanup: () async {
                                    print('cleanup');
                                    print(room['roomNo']);
                                    print(room['status']);
                                    await postImage2(
                                      room['roomNo'],
                                    );
                                    await room.reference.update({
                                      'status': 'vacant',
                                    });
                                    _file2 = null;
                                  },
                                  oncheckout: () {
                                    print('checkout');
                                    print(room['roomNo']);
                                    print(room['status']);
                                    postImage(
                                      room['roomNo'],
                                    );
                                  },
                                  status: room['status'],
                                  onTap: () {
                                    if (room.exists) {
                                      room.reference.update({
                                        'status': 'cleaning',
                                      });
                                    } else {
                                      print('Room does not exist');
                                    }
                                  },
                                  roomNo: room['roomNo'],
                                  checkInTime: room['checkInTime'].toDate(),
                                  checkOutTime: room['checkOutTime'].toDate());
                            });
                      },
                    )
                    // ListView.builder(
                    //   shrinkWrap: true,
                    //   itemCount: _roomCards.length,
                    //   itemBuilder: (context, index) {
                    //     return _roomCards[index];
                    //   },
                    // ),
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
