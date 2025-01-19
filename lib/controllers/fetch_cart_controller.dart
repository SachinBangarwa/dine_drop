import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FetchCartController extends GetxController {
  User? user = FirebaseAuth.instance.currentUser;

  RxInt total = 0.obs;


  void calculateTotal( snapshot) {
    int calculatedTotal = 0;

    for (var doc in snapshot.docs) {
      calculatedTotal += (doc['total'] ?? 0) as int;
    }

    total.value = calculatedTotal;
  }


  Stream<QuerySnapshot<Map<String, dynamic>>> fetchFoodSnapshots() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('cart')
        .snapshots();
  }
}
