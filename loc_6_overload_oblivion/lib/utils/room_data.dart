import 'package:cloud_firestore/cloud_firestore.dart';

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

void uploadRoomData(Map<String, dynamic> roomData) async {
  try {
    // Get a reference to the Firestore collection
    CollectionReference roomsCollection =
        FirebaseFirestore.instance.collection('rooms');

    // Upload each room data to Firestore
    roomData.forEach((roomNo, data) async {
      await roomsCollection.doc(roomNo).set(data);
    });

    print('Room data uploaded successfully!');
  } catch (e) {
    print('Error uploading room data: $e');
  }
}
