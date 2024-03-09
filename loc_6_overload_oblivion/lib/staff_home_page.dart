import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart'; // Add this import statement

class StaffHomePage extends StatefulWidget {
  const StaffHomePage({Key? key}) : super(key: key);

  @override
  State<StaffHomePage> createState() => _StaffHomePageState();
}

class _StaffHomePageState extends State<StaffHomePage> {
  DateTime? startDateTime;
  DateTime? endDateTime;

  DateTime? startDate;
  TimeOfDay? startTime;
  DateTime? endDate;
  TimeOfDay? endTime;

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
                Container(
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
                SizedBox(height: 20),
                Container(
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
                          SizedBox(
                            width: 300,
                            height: 50,
                            child: TextField(
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
                          // ElevatedButton(
                          //   onPressed: () async {
                          //     final selectedDate =
                          //         await showMyDatePicker(context);
                          //     if (selectedDate != null) {
                          //       setState(() {
                          //         startDate = selectedDate;
                          //       });
                          //     }
                          //   },
                          //   child: Text('Select Start Date'),
                          // ),
                          // SizedBox(height: 20),
                          // ElevatedButton(
                          //   onPressed: () async {
                          //     final selectedTime =
                          //         await showMyTimePicker(context);
                          //     if (selectedTime != null) {
                          //       setState(() {
                          //         startTime = selectedTime;
                          //       });
                          //     }
                          //   },
                          //   child: Text('Select Start Time'),
                          // ),
                          // SizedBox(height: 20),
                          // ElevatedButton(
                          //   onPressed: () async {
                          //     final selectedDate =
                          //         await showMyDatePicker(context);
                          //     if (selectedDate != null) {
                          //       setState(() {
                          //         endDate = selectedDate;
                          //       });
                          //     }
                          //   },
                          //   child: Text('Select End Date'),
                          // ),
                          // SizedBox(height: 20),
                          // ElevatedButton(
                          //   onPressed: () async {
                          //     final selectedTime =
                          //         await showMyTimePicker(context);
                          //     if (selectedTime != null) {
                          //       setState(() {
                          //         endTime = selectedTime;
                          //       });
                          //     }
                          //   },
                          //   child: Text('Select End Time'),
                          // ),
                          SizedBox(height: 20),
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
                                print('Start DateTime: $startDateTime');
                                print('End DateTime: $endDateTime');
                              } else {
                                print('Please select start and end date/time');
                              }
                            },
                            child: Text('Combine and Store DateTime'),
                          ),
                        ],
                      ),
                    )),
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
      lastDate: DateTime.now(),
    );
    if (selectedDate != null) {
      // Do something with the selected date
      print('Selected date: $selectedDate');
    }
    return selectedDate;
  }
}
