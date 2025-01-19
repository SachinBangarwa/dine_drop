import 'package:dine_drop/pages/core/show_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ForgotController extends GetxController {
  final auth = FirebaseAuth.instance;

  Future forgetPassword(String email) async {
    try {
     await auth.sendPasswordResetEmail(email: email);
      showToast('Password Reset Email has been Send!');
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        showToast('User not found');
      }
      showToast(e.code.toString());
    } catch (e) {
      showToast(e.toString());
    }
  }
}
