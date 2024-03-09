import 'package:cloud_firestore/cloud_firestore.dart';

class Staff {
  final String staffid;
  final String uid;
  final String email;

  Staff({
    required this.staffid,
    required this.uid,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'staffid': staffid,
      'email': email,
    };
  }

  static Staff fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    print(snapshot.toString());
    return Staff(
      uid: snapshot['uid'],
      staffid: snapshot['staffid'],
      email: snapshot['email'],
    );
  }
}
