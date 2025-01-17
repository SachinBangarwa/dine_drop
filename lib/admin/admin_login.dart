import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dine_drop/admin/home_admin.dart';
import 'package:dine_drop/pages/core/show_toast.dart';
import 'package:dine_drop/pages/widget/support_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminLogin extends StatelessWidget {
  AdminLogin({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _fromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: Get.height / 1.8,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(45),
                      topRight: Radius.circular(45))),
            ),
          ),
          Positioned(
              top: 65,
              left: 100,
              child: Text(
                "Let's start with\n        Admin!",
                style: AppSupportWidget.boldTextStyle(),
              )),
          Positioned(
              top: 200,
              left: 25,
              right: 25,
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Colors.white,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 35),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                          backgroundColor: Colors.orange,
                          child: Icon(
                            Icons.opacity_rounded,
                            size: 25,
                          )),
                      SizedBox(
                        height: Get.height / 40,
                      ),
                      SizedBox(
                        height: Get.height / 15,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the Email';
                            }
                            return null;
                          },
                          controller: _emailController,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              hintText: 'Email',
                              border: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                      SizedBox(
                        height: Get.height / 30,
                      ),
                      SizedBox(
                        height: Get.height / 15,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the Password';
                            }
                            return null;
                          },
                          controller: _passwordController,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              hintText: 'Password',
                              border: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                      SizedBox(
                        height: Get.height / 25,
                      ),
                      InkWell(
                        onTap: () async {
                          if (_fromKey.currentState?.validate() ?? false) {}
                          await _onHandlerAdminLogin();
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(bottom: 25),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                                fontFamily: 'Poppins', color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Future _onHandlerAdminLogin() async {
    await FirebaseFirestore.instance.collection('admin').get().then((snapShot) {
      for (var doc in snapShot.docs) {
        if (doc.data()['id'] == _emailController.text.trim()) {
          if (doc.data()['password'] == _passwordController.text.trim()) {
            Get.offAll(() => const HomeAdmin());
          } else {
            showToast('Wrong password');
          }
        } else {
          showToast('Wrong Email');
        }
      }
    });
  }
}
