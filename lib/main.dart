import 'package:dine_drop/firebase_options.dart';
import 'package:dine_drop/pages/dashboard_page.dart';
import 'package:dine_drop/pages/on_board_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Stripe.publishableKey =
      'pk_test_51QhSPeBujAXMH72F3eQY9z7VQXLQ89ArvgLpgSEjy9ZH8'
      'xhF3iXZsFV5CHFn0I14EqHwN2cceG6YCHxMGMukgQwF00tUu2o0lb';
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: (FirebaseAuth.instance.currentUser != null)
          ? const DashboardPage()
          : const OnBoardPage(),
    );
  }
}
