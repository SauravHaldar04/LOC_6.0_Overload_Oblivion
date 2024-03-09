import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loc_6_overload_oblivion/models/staff_model.dart';
import 'package:loc_6_overload_oblivion/models/admin_model.dart';

class AuthMethods {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<String> signUpStaff({
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

  Future<String> loginStaff({
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
  Future<String> signUpAdmin({
    required String email,
    required String password,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        UserCredential userCredential = await _auth
            .createUserWithEmailAndPassword(email: email, password: password);
        print(userCredential.user!.uid);

        Admin admin = Admin(
            uid: userCredential.user!.uid, 
            email: email,);
        await _firestore
            .collection('admin')
            .doc(userCredential.user!.uid)
            .set(admin.toJson());
        res = "Success";
      } else {
        res = 'Please enter all the fields';
      }
      return res;
    } catch (err) {
      return err.toString();
    }
  }

  Future<String> loginAdmin({
    required String email,
    required String password,
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
   Future<Staff> getStaffDetails() async {
    User currentUser = _auth.currentUser!;
    print(currentUser.email);
    DocumentSnapshot snap =
        await _firestore.collection('staff').doc(currentUser.uid).get();

    // print((snap.data() as Map<String, dynamic>)['username'] as String);

    return Staff.fromSnap(snap);
  }
}
