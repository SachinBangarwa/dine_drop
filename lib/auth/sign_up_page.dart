import 'package:dine_drop/auth/log_in_page.dart';
import 'package:dine_drop/controllers/sign_up_controller.dart';
import 'package:dine_drop/pages/dashboard_page.dart';
import 'package:dine_drop/pages/widget/support_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final _signUpController = Get.put(SignUpController());
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _fromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              alignment: Alignment.topCenter,
              width: double.infinity,
              height: Get.height / 2.5,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFff5c30),
                      Color(0xFFe74b1a),
                    ]),
              ),
              child: Padding(
                padding: const EdgeInsets.all(45.0),
                child: Image.asset('images/logo.png'),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: Get.height / 2.8),
              width: double.infinity,
              height: Get.height / 1.6,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30))),
              child: Padding(
                padding: EdgeInsets.only(top: Get.height / 2),
                child: InkWell(
                  onTap: () {
                    Get.to(() => LogInPage());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: AppSupportWidget.mediumTextStyle(),
                      ),
                      Text(
                        " Log In",
                        style: AppSupportWidget.mediumTextStyle(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              color: Colors.white,
              margin: EdgeInsets.only(
                top: Get.height / 4,
                left: Get.height / 35,
                right: Get.height / 35,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 5,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Form(
                  key: _fromKey,
                  child: Column(
                    children: [
                      Text(
                        'Sign Up',
                        style: AppSupportWidget.boldTextStyle(),
                      ),
                      SizedBox(
                        height: Get.height / 60,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the Name';
                          }
                          return null;
                        },
                        style: AppSupportWidget.mediumTextStyle(),
                        keyboardType: TextInputType.text,
                        controller: _nameController,
                        decoration: InputDecoration(
                          hintStyle: AppSupportWidget.mediumTextStyle(),
                          hintText: 'Name',
                          prefixIcon: const Icon(Icons.person),
                        ),
                      ),
                      SizedBox(
                        height: Get.height / 60,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the Email';
                          }
                          return null;
                        },
                        style: AppSupportWidget.mediumTextStyle(),
                        keyboardType: TextInputType.name,
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintStyle: AppSupportWidget.mediumTextStyle(),
                          hintText: 'Email',
                          prefixIcon: const Icon(Icons.email_outlined),
                        ),
                      ),
                      SizedBox(
                        height: Get.height / 60,
                      ),
                      Obx(() => TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the Password';
                              }
                              return null;
                            },
                            style: AppSupportWidget.mediumTextStyle(),
                            controller: _passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: _signUpController.visible.value,
                            decoration: InputDecoration(
                                hintStyle: AppSupportWidget.mediumTextStyle(),
                                hintText: 'Password',
                                prefixIcon: const Icon(Icons.password_outlined),
                                suffixIcon: InkWell(
                                  splashColor: Colors.blueGrey,
                                  child: Icon(_signUpController.visible.value
                                      ? Icons.remove_red_eye
                                      : Icons.visibility_off),
                                  onTap: () {
                                    _signUpController.visible.toggle();
                                  },
                                )),
                          )),
                      SizedBox(
                        height: Get.height / 30,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFff5c30),
                              padding: EdgeInsets.symmetric(
                                  horizontal: Get.width / 8,
                                  vertical: Get.height / 85)),
                          onPressed: () async {
                            if (_fromKey.currentState?.validate() ?? false) {
                              await _onPressHandlerLogin();
                            }
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.white, fontFamily: 'Poppins'),
                          )),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future _onPressHandlerLogin() async {
    await _signUpController
        .signUpController(
            _emailController.text.trim(), _passwordController.text.trim())
        .then((value) {
      if (value != null) {
        Get.offAll(() => const DashboardPage());
      }
    });
  }
}
