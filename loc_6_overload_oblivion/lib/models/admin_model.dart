import 'package:cloud_firestore/cloud_firestore.dart';

class Admin {
  final String uid;
  final String email;

  Admin({
    required this.uid,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
    };
  }

  static Admin fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    print(snapshot.toString());
    return Admin(
      uid: snapshot['uid'],
      email: snapshot['email'],
    );
  }
}
