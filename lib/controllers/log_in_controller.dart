import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dine_drop/pages/core/show_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class LogInController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFireStore=FirebaseFirestore.instance;
  RxBool visible = true.obs;

  Future<UserCredential?> loginController(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if(_auth.currentUser!=null) {
        Map<String, dynamic> userData = {
          'userEmail': _auth.currentUser!.email.toString(),
          'UserUid':_auth.currentUser!.uid.toString(),
          'wallet':'100',
        };
        await _firebaseFireStore.collection('users').doc().set(userData);
      }
      showToast('Login Successful!');
      return credential;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          showToast('No user found for this email.');
          break;
        case 'wrong-password':
          showToast('Incorrect password. Please try again.');
          break;
        case 'invalid-email':
          showToast('The email address is not valid.');
          break;
        case 'user-disabled':
          showToast('This account has been disabled.');
          break;
        default:
          showToast('An error occurred: ${e.message}');
          break;
      }
    } catch (e) {
      showToast('An unexpected error occurred: ${e.toString()}');
    }
    return null;
  }
}
