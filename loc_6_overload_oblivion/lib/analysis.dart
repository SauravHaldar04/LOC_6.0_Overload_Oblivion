import 'dart:convert';
import 'dart:typed_data';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:loc_6_overload_oblivion/global/global_variables.dart';
import 'package:loc_6_overload_oblivion/utils/utils.dart';

class Analysis extends StatefulWidget {
  @override
  _AnalysisState createState() => _AnalysisState();
}

class _AnalysisState extends State<Analysis> {
  List<dynamic> itemCounts = [];
  List<dynamic> items = [];
  Uint8List? _file;
  Uint8List? _file2;
  Uint8List? _file3;
  @override
  void initState() {
    super.initState();
    // Call the method to send the POST request and receive the data
    postImageAndGetCounts();
  }

  Future<void> postImageAndGetCounts() async {
    // Convert the selected image to base64 format
    ;

    // Send the POST request with the base64 image
    var response = await http.post(
      Uri.parse('${GlobalVariables.url}/inventory'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'image': base64Encode(_file!)}),
    );
    print(response.body);
    if (response.statusCode == 200) {
      // Decode the received JSON data
      var jsonData = jsonDecode(response.body);

      // Extract the counts of each item

      // Update the item counts in the state
      setState(() {
        itemCounts = jsonData['class_names_and_counts'].toList();
        print(itemCounts);
      });
    }
  }

  Future<void> postImageGetData() async {
    // Convert the selected image to base64 format

    // Send the POST request with the base64 image
    var response = await http.post(
      Uri.parse('${GlobalVariables.url}/unclean'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'image': base64Encode(_file2!)}),
    );
    print(response.body);
    if (response.statusCode == 200) {
      // Decode the received JSON data
      var jsonData = jsonDecode(response.body);
      print(jsonData);

      // Extract the counts of each item

      // Update the item counts in the state
      setState(() {
        //items = jsonData['class_names'].toList();
        //print(itemCounts);
        _file3 = base64Decode(jsonData['image']);
        //print(base64Encode(_file3));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
      appBar: AppBar(
        title: Text('Analysis'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                                    'Add Room Image ',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey.shade400),
                                  )
                                ]),
                          ),
                        ),
                      )
                    : Container(
                        height: 400,
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
                  height: 30,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(),
                      onPressed: () async {
                        await postImageGetData();
                      },
                      child: Text('Analyse room dirtiness')),
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(),
                      onPressed: () {
                        setState(() {
                          _file2 = null;

                          items = [];
                        });
                      },
                      child: Text('Clear Image')),
                ),
                // SizedBox(
                //   height: 200,
                //   width: double.infinity,
                //   child: Center(
                //     child: ListView.builder(
                //         itemCount: items.length,
                //         itemBuilder: (context, index) {
                //           return Padding(
                //             padding: const EdgeInsets.all(15.0),
                //             child: Center(
                //               child: Text(
                //                 'There are ${items[index]} ${items[index][0]} ',
                //                 style: TextStyle(
                //                     fontWeight: FontWeight.bold, fontSize: 20),
                //               ),
                //             ),
                //           );
                //         }),
                //   ),
                // ),
                SizedBox(
                  height: 30,
                ),
                _file3 == null
                    ? Container()
                    : Container(
                        height: 400,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          image: DecorationImage(
                            image: MemoryImage(_file3!),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
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
                                    'Add Room Image ',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey.shade400),
                                  )
                                ]),
                          ),
                        ),
                      )
                    : Container(
                        height: 400,
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
                  height: 30,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(),
                      onPressed: () async {
                        await postImageAndGetCounts();
                      },
                      child: Text('Analyze inventory')),
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(),
                      onPressed: () {
                        setState(() {
                          _file = null;
                          itemCounts = [];
                        });
                      },
                      child: Text('Clear Image')),
                ),
                SizedBox(
                  height: 500,
                  width: double.infinity,
                  child: Center(
                    child: ListView.builder(
                        itemCount: itemCounts.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Center(
                              child: Text(
                                'There are ${itemCounts[index][1]} ${itemCounts[index][0]} ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                          );
                        }),
                  ),
                )
                // Column(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: itemCounts.entries.map((entry) {
                //     String itemName = entry.key;
                //     int itemCount = entry.value;
                //     return Text('$itemName: $itemCount');
                //   }).toList(),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
