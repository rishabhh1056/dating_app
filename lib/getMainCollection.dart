import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GetMainCollection{
  User? user = FirebaseAuth.instance.currentUser;


  DocumentReference getCollection(){
  String? uid = user?.uid;
  return FirebaseFirestore.instance.collection('users').doc(uid);
}


  Future<Map<String, dynamic>?> getUserData(String uid, String subDoc) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // Navigate to the document path
      DocumentSnapshot<Map<String, dynamic>> snapshot = await firestore
          .collection('users') // Main collection
          .doc(uid) // Document with UID
          .collection('userData') // Subcollection
          .doc(subDoc) // Document
          .get();

      if (snapshot.exists) {
        return snapshot.data(); // Return the data if document exists
      } else {
        print("No such document!");
        return null; // Return null if the document does not exist
      }
    } catch (e) {
      print("Error fetching user data: $e");
      return null; // Return null in case of an error
    }
  }
}