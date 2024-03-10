import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loc_6_overload_oblivion/analysis.dart';
import 'package:loc_6_overload_oblivion/global/global_variables.dart';
import 'package:loc_6_overload_oblivion/models/staff_model.dart';
import 'package:loc_6_overload_oblivion/provider/staff_provider.dart';
import 'package:loc_6_overload_oblivion/resources/storage_methods.dart';
import 'package:loc_6_overload_oblivion/utils/room_data.dart';
import 'package:loc_6_overload_oblivion/utils/utils.dart'; // Add this import statement
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class StaffHomePage extends StatefulWidget {
  const StaffHomePage({Key? key}) : super(key: key);

  @override
  State<StaffHomePage> createState() => _StaffHomePageState();
}

class _StaffHomePageState extends State<StaffHomePage> {
  Uint8List? _file;
  Uint8List? _file2;
  bool isClicked = false;
  bool isClicked2 = false;
  DateTime? startDateTime;
  DateTime? endDateTime;

  DateTime? startDate;
  TimeOfDay? startTime;
  DateTime? endDate;
  TimeOfDay? endTime;
  TextEditingController _roomNoController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    addData();
  }

  void addData() async {
    StaffProvider _staffProvider = Provider.of(context, listen: false);
    await _staffProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> cleanliness() async {
      try {
        var response =
            await http.post(Uri.parse('${GlobalVariables.url}/predict'),
                headers: <String, String>{
                  'Content-Type': 'application/json; charset=UTF-8',
                },
                body: jsonEncode({'image': base64Encode(_file2!)}));
        print(response.body);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Cleanliness Analysis'),
                content: jsonDecode(response.body)['predicted_labels'][0] ==
                        'messy'
                    ? Text(
                        'The room is ${jsonDecode(response.body)['predicted_labels'][0]} and the level of dirtiness is ${jsonDecode(response.body)['score']}% ')
                    : Text(
                        'The room is ${jsonDecode(response.body)['predicted_labels'][0]} and the level of cleanliness is ${jsonDecode(response.body)['score']}% '),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            });
      } catch (e) {
        print(e.toString());
      }
    }

    postImage() async {
      Staff _staff =
          Provider.of<StaffProvider>(context, listen: false).getUser();
      String res = await StorageMethods().postImage(
        staffID: _staff.staffid,
        roomNo: int.parse(_roomNoController.text),
        image: _file!,
        checkInTime: startDateTime!,
        checkOutTime: endDateTime!,
      );

      showSnackBar(context, res);
    }

    Map<String, dynamic> generateRoomData() {
      Map<String, dynamic> roomData = {};

      for (int i = 101; i <= 505; i += 100) {
        for (int j = 1; j <= 5; j++) {
          String roomNo = (i + j).toString();
          roomData[roomNo] = {"roomNo": roomNo, "status": "vacant"};
        }
      }

      return roomData;
    }

    selectImage(BuildContext context) {
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
                      _file = file;
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
                      _file = file;
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

    selectImage2(BuildContext context) {
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
                  'Welcome Staff',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isClicked = !isClicked;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
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
                    child: Row(
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 40,
                        ),
                        SizedBox(width: 40),
                        Text(
                          'Allocate Room',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isClicked2 = !isClicked2;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
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
                    child: Row(
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 40,
                        ),
                        SizedBox(width: 40),
                        Text(
                          'Analyze Room',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                isClicked
                    ? Container(
                        padding: EdgeInsets.all(20),
                        height: 470,
                        width: MediaQuery.of(context).size.width - 50,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(99, 40, 40, 40),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 7,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 25,
                              ),
                              SizedBox(
                                width: 300,
                                height: 50,
                                child: TextField(
                                  controller: _roomNoController,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor:
                                        const Color.fromARGB(255, 86, 86, 86),
                                    labelStyle: TextStyle(
                                      color: Color.fromRGBO(255, 255, 255, 1),
                                    ),
                                    hintStyle: TextStyle(
                                      color: Color.fromRGBO(255, 255, 255, 1),
                                    ),
                                    hintText: "Enter Room No",
                                    labelText: "Room No",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: Color.fromRGBO(8, 17, 40, 1),
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: Color.fromRGBO(8, 17, 40, 1),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: Color.fromRGBO(8, 17, 40, 1),
                                      ),
                                    ),
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              GestureDetector(
                                onTap: () async {
                                  final selectedDate =
                                      await showMyDatePicker(context);
                                  if (selectedDate != null) {
                                    setState(() {
                                      startDate = selectedDate;
                                    });
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.all(15),
                                  width: MediaQuery.of(context).size.width - 70,
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 58, 58, 58),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 5,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_today_sharp,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                      SizedBox(width: 40),
                                      Text(
                                        'Select Start Date',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              GestureDetector(
                                onTap: () async {
                                  final selectedTime =
                                      await showMyTimePicker(context);
                                  if (selectedTime != null) {
                                    setState(() {
                                      startTime = selectedTime;
                                    });
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.all(15),
                                  width: MediaQuery.of(context).size.width - 70,
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 58, 58, 58),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 5,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.access_alarm,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                      SizedBox(width: 40),
                                      Text(
                                        'Select Start Time',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              GestureDetector(
                                onTap: () async {
                                  final selectedDate =
                                      await showMyDatePicker(context);
                                  if (selectedDate != null) {
                                    setState(() {
                                      endDate = selectedDate;
                                    });
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.all(15),
                                  width: MediaQuery.of(context).size.width - 70,
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 58, 58, 58),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 5,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_today_sharp,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                      SizedBox(width: 40),
                                      Text(
                                        'Select End Date',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              GestureDetector(
                                onTap: () async {
                                  final selectedTime =
                                      await showMyTimePicker(context);
                                  if (selectedTime != null) {
                                    setState(() {
                                      endTime = selectedTime;
                                    });
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.all(15),
                                  width: MediaQuery.of(context).size.width - 70,
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 58, 58, 58),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 5,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.access_alarm,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                      SizedBox(width: 40),
                                      Text(
                                        'Select End Time',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              _file == null
                                  ? GestureDetector(
                                      onTap: () {
                                        selectImage(context);
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
                                                  'Add Room Image Before Check In',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color:
                                                          Colors.grey.shade400),
                                                )
                                              ]),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      height: 300,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        image: DecorationImage(
                                          image: MemoryImage(_file!),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                              SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  if (startDate != null &&
                                      startTime != null &&
                                      endDate != null &&
                                      endTime != null) {
                                    startDateTime = DateTime(
                                      startDate!.year,
                                      startDate!.month,
                                      startDate!.day,
                                      startTime!.hour,
                                      startTime!.minute,
                                    );
                                    endDateTime = DateTime(
                                      endDate!.year,
                                      endDate!.month,
                                      endDate!.day,
                                      endTime!.hour,
                                      endTime!.minute,
                                    );

                                    postImage();
                                    setState(() {
                                      _file = null;
                                    });

                                    setState(() {
                                      isClicked = !isClicked;
                                    });
                                    print('Start DateTime: $startDateTime');
                                    print('End DateTime: $endDateTime');
                                  } else {
                                    print(
                                        'Please select start and end date/time');
                                  }
                                },
                                child: Text('Add room'),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(),
                isClicked2
                    ? Container(
                        padding: EdgeInsets.all(20),
                        height: 500,
                        width: MediaQuery.of(context).size.width - 50,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(99, 40, 40, 40),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 7,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 25,
                              ),
                              SizedBox(height: 20),
                              _file2 == null
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
                                                  'Add Room Image Before Check In',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color:
                                                          Colors.grey.shade400),
                                                )
                                              ]),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      height: 300,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        image: DecorationImage(
                                          image: MemoryImage(_file2!),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                              SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  await cleanliness();
                                  _file2 = null;
                                },
                                child: Text('Add room'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  // Navigate to another page
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Analysis()),
                                  );
                                },
                                child: Text('Get Analysis'),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<TimeOfDay?> showMyTimePicker(BuildContext context) async {
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (selectedTime != null) {
      // Do something with the selected time
      print('Selected time: ${selectedTime.hour}:${selectedTime.minute}');
    }
    return selectedTime;
  }

  Future<DateTime?> showMyDatePicker(BuildContext context) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020, 1, 1),
      lastDate: DateTime(2025, 1, 1),
    );
    if (selectedDate != null) {
      // Do something with the selected date
      print('Selected date: $selectedDate');
    }
    return selectedDate;
  }
}
