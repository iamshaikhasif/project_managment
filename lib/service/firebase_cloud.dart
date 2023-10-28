import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseCloud {
  FirebaseCloud._();
  static final instance = FirebaseCloud._();

 final String userCollection = "User";

  Future<void> createUserDoc(
      {required UserCredential? userCredential,
      required String collectionName,
      required Map<String, dynamic> data}) async {
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(userCredential.user!.email)
          .set(data);
    }
  }
}
