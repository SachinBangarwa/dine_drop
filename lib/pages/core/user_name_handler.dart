import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserNameHandler{
  static User user = FirebaseAuth.instance.currentUser!;

 static String getNameFromEmail() {
    String localPart =user.email!.split('@').first;

    RegExp regex = RegExp(r'^\D+');
    Match? match = regex.firstMatch(localPart);

    if (match != null) {
      return match.group(0)?.capitalizeFirst??'';
    } else {
      return '';
    }
  }
}