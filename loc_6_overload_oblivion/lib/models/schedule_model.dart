import 'package:cloud_firestore/cloud_firestore.dart';

class Schedule {
  final String scheduleid;
  final int roomNo;
  final String imageUrl;
  final String encodedImage;
  final DateTime checkInTime;
  final DateTime checkOutTime;
  final String staffID;

  Schedule({
    required this.staffID,
    required this.roomNo,
    required this.scheduleid,
    required this.imageUrl,
    required this.encodedImage,
    required this.checkInTime,
    required this.checkOutTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'scheduleid': scheduleid,
      'imageUrl': imageUrl,
      'encodedImage': encodedImage,
      'checkInTime': checkInTime,
      'checkOutTime': checkOutTime,
      'roomNo': roomNo,
      'staffID': staffID

    };
  }

  static Schedule fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    print(snapshot.toString());
    return Schedule(
        scheduleid: snapshot['scheduleid'],
        imageUrl: snapshot['imageUrl'],
        encodedImage: snapshot['encodedImage'],
        checkInTime: snapshot['checkInTime'],
        checkOutTime: snapshot['checkOutTime'],
        roomNo: snapshot['roomNo'],
        staffID: snapshot['staffID']);

  }
}
