import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseApi {
  static final firestore = FirebaseFirestore.instance;
  static final firebaseMessanging = FirebaseMessaging.instance;
  static FirebaseStorage storage = FirebaseStorage.instance;

  static Future<DocumentSnapshot<Map<String, dynamic>>> getUserData(
      String uid) {
    return firestore.collection("Profile").doc(uid).get();
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> checkIfRefferalExists(
      {required String code}) {
    return firestore
        .collection("Profile")
        .where("referralCode", isEqualTo: code)
        .get();
  }

  static Future<String?> getDeviceToken() async {
    return await firebaseMessanging.getToken();
  }

  static Future<String> uploadPic(
      {required String folder,
      required String fileName,
      required File image}) async {
    String _url = "error";
    Reference ref = storage.ref().child(folder).child(fileName);
    UploadTask uploadTask = ref.putFile(image);
    await uploadTask.then((res) async {
      _url = await res.ref.getDownloadURL();
    }, onError: (e, t) {
      print(e.toString());
      return "error";
    });
    return _url;
  }

  static void uploadData(
      String collection, String? doc, Map<String, dynamic> data) {
    if (doc == null) {
      firestore.collection(collection).add(data);
    } else {
      firestore.collection(collection).doc(doc).set(data);
    }
  }

  static updateData({required String collection,required String doc,required Map<String,dynamic> data}) {
    firestore.collection(collection).doc(doc).update(data);
  }

  static Future<String> getProfileImage(String uid) async {
    Reference ref = storage.ref().child("Profile").child(uid);
    return await ref.getDownloadURL();
  }
}
