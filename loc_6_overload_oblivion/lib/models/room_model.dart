import 'package:cloud_firestore/cloud_firestore.dart';

class Room {
  final String roomNo;
  final String status;

  Room({
    required this.roomNo,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {'roomNo': roomNo, 'status': status};
  }

  static Room fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    print(snapshot.toString());
    return Room(
      roomNo: snapshot['roomNo'],
      status: snapshot['status'],
    );
  }
}
