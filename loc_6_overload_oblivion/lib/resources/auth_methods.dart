import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loc_6_overload_oblivion/models/staff_model.dart';

class AuthMethods {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<String> signUpUser({
    required String staffid,
    required String email,
    required String password,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        UserCredential userCredential = await _auth
            .createUserWithEmailAndPassword(email: email, password: password);
        print(userCredential.user!.uid);

        Staff staff = Staff(
            uid: userCredential.user!.uid, email: email, staffid: staffid);
        await _firestore
            .collection('staff')
            .doc(userCredential.user!.uid)
            .set(staff.toJson());
        res = "Success";
      } else {
        res = 'Please enter all the fields';
      }
      return res;
    } catch (err) {
      return err.toString();
    }
  }

  Future<String> loginUser({
    required String email,
    required String password,
    required String staffid,
  }) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    String res = "Some error occured";
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "Success";
      } else {
        res = 'Please enter all the fields';
      }
      return res;
    } catch (err) {
      return err.toString();
    }
  }
}
