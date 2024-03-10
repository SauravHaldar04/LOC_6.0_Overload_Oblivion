import 'dart:async';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:loc_6_overload_oblivion/models/schedule_model.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final _auth = FirebaseAuth.instance;
  Future<String> uploadImage(
      String childName, String childName2, Uint8List file) async {
    Reference ref = _firebaseStorage.ref().child(childName).child(childName2);

    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> postImage({
    required String staffID,
    required int roomNo,
    required Uint8List image,
    required DateTime checkInTime,
    required DateTime checkOutTime,
  }) async {
    String res = "Some error occured";
    try {
      String scheduleId = Uuid().v1();
      String imageUrl = await StorageMethods().uploadImage(
        'checkInImages',
        scheduleId,
        image,
      );

      Schedule schedule = Schedule(
        roomNo: roomNo,
        scheduleid: scheduleId,
        imageUrl: imageUrl,
        encodedImage: '',
        checkInTime: checkInTime,
        checkOutTime: checkOutTime,
        staffID: staffID
      );
      FirebaseFirestore.instance
          .collection('staff')
          .doc(_auth.currentUser!.uid)
          .collection('schedule')
          .doc(scheduleId)
          .set(schedule.toJson());
      FirebaseFirestore.instance
          .collection('rooms')
          .doc(roomNo.toString())
          .collection('schedule')
          .doc(scheduleId)
          .set(schedule.toJson());
      FirebaseFirestore.instance
          .collection('rooms')
          .doc(roomNo.toString())
          .update({
        'status': 'occupied',
        'checkInTime': checkInTime,
        'checkOutTime': checkOutTime,
        'staffID':staffID
      });
      res = 'Image uploaded successfully';
    } catch (err) {
      return err.toString();
    }
    return res;
  }
   Future<String> postImage2({
    required int roomNo,
    required Uint8List image,
    required String scheduleId,
    required DateTime cleanStartTime,
  }) async {
    String res = "Some error occured";
    try {
      String imageUrl = await StorageMethods().uploadImage(
        'checkOutImages',
        scheduleId,
        image,
      );
      FirebaseFirestore.instance
          .collection('staff')
          .doc(_auth.currentUser!.uid)
          .collection('schedule')
          .doc(scheduleId)
          .update({
        'checkOutImage': imageUrl,
          });
          FirebaseFirestore.instance
          .collection('staff')
          .doc(_auth.currentUser!.uid)
          .update({
        'cleanStartTime': cleanStartTime,
          });
      FirebaseFirestore.instance
          .collection('rooms')
          .doc(roomNo.toString())
          .collection('schedule')
          .doc(scheduleId)
          .update({
        'checkOutImage': imageUrl,
          });
      FirebaseFirestore.instance
          .collection('rooms')
          .doc(roomNo.toString())
          .update({
        'checkOutImage': imageUrl
      });
      res = 'Image uploaded successfully';
    } catch (err) {
      return err.toString();
    }
    return res;
  }
  Future<String> postImage3({
    required int roomNo,
    required Uint8List image,
    required String scheduleId,
    required DateTime cleanEndTime,
  }) async {
    String res = "Some error occured";
    try {
      String imageUrl = await StorageMethods().uploadImage(
        'cleanUpImages',
        scheduleId,
        image,
      );
      FirebaseFirestore.instance
          .collection('staff')
          .doc(_auth.currentUser!.uid)
          .collection('schedule')
          .doc(scheduleId)
          .update({
        'cleanupImage': imageUrl,
          });
          FirebaseFirestore.instance
          .collection('staff')
          .doc(_auth.currentUser!.uid)
          .update({
        'cleanEndTime': cleanEndTime,
          });
      FirebaseFirestore.instance
          .collection('rooms')
          .doc(roomNo.toString())
          .collection('schedule')
          .doc(scheduleId)
          .update({
        'cleanupImage': imageUrl,
          });
      FirebaseFirestore.instance
          .collection('rooms')
          .doc(roomNo.toString())
          .update({
        'cleanupImage': imageUrl
      });
      res = 'Image uploaded successfully';
    } catch (err) {
      return err.toString();
    }
    return res;
  }
}

