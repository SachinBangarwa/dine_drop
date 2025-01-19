import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class FetchFoodController extends GetxController {

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchHorizontalFood(selectedCategory) {
    return FirebaseFirestore.instance
        .collection(selectedCategory)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchVerticalFood(selectedCategory) {
    return FirebaseFirestore.instance
        .collection(selectedCategory)
        .snapshots();
  }
}
