

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final BasicDetailsProvider =StateNotifierProvider<BasicDetailsNotifier, Map<String, dynamic>?> (
    (ref) =>BasicDetailsNotifier()
);

final profilePhotosProvider = StateNotifierProvider<BasicDetailsNotifier, Map<String, dynamic>?>(
      (ref) => BasicDetailsNotifier(),
);

final profileVerificationProvider = StateNotifierProvider<BasicDetailsNotifier, Map<String, dynamic>?>(
      (ref) => BasicDetailsNotifier(),
);

final termAndConditionDetailProvider = StateNotifierProvider<BasicDetailsNotifier, Map<String, dynamic>?>(
      (ref) => BasicDetailsNotifier(),
);

class BasicDetailsNotifier extends StateNotifier<Map<String, dynamic>?>{
  BasicDetailsNotifier() :super(null);

  Future<void> fetchFirebaseData(String uid, String subDoc) async{

    try{
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('userData')
          .doc(subDoc)
          .get();
      if (snapshot.exists) {
        state = snapshot.data();
      } else {
        state = null; // No data found
        print("state get null....");
      }
    }
    catch(e){
      print("Error fetching user basic details: $e");
      state = null;
    }
  }
}