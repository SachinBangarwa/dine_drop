import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dine_drop/pages/core/show_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFireStore=FirebaseFirestore.instance;
  RxBool visible = true.obs;

  Future<UserCredential?> signUpController(
      String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if(_auth.currentUser!=null) {
        Map<String, dynamic> userData = {
          'userEmail': email.toString(),
          'UserUid':_auth.currentUser!.uid.toString(),
          'wallet':'100',

        };
        await _firebaseFireStore.collection('users').doc().set(userData);
      }
      showToast('Sign-Up Successful!');
      return credential;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          showToast('The password provided is too weak.');
          break;
        case 'email-already-in-use':
          showToast('An account already exists for this email.');
          break;
        case 'invalid-email':
          showToast('The email address is not valid.');
          break;
        default:
          showToast('An error occurred: ${e.message}');
          break;
      }
    } catch (e) {
      showToast('An unexpected error occurred: ${e.toString()}');
      print("Error:${e}");
    }
    return null;
  }
}
