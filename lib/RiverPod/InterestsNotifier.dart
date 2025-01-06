

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Define the Provider
final interestsProvider =
StateNotifierProvider<InterestsNotifier, List<String>>((ref) {
  return InterestsNotifier();
});

class InterestsNotifier extends StateNotifier<List<String>> {
  InterestsNotifier() :super([]);

  Future<void> initialize(String uid, String subDoc) async {
    await fetchInterests(uid, subDoc);
  }

  Future<void> fetchInterests(String uid, String subDoc) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('userData')
          .doc(subDoc)
          .get();

      if (snapshot.exists) {
        final data = snapshot.data();
        List<String> fetchedInterests = List<String>.from(data?['interests'] ?? []);
        state = fetchedInterests;
      }
    } catch (e) {
      print("Error fetching interests: $e");
    }
  }
}