import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dine_drop/pages/core/show_toast.dart';

class UploadItemCloudService {
  static Future uploadItem(
      Map<String, dynamic> items, String categoryName) async {
    await  FirebaseFirestore.instance.collection(categoryName).add(items).then((onValue){
      showToast('Add to Item SuccessFull');
    });
  }
}
