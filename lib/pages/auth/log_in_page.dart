import 'package:dine_drop/pages/auth/sign_up_page.dart';
import 'package:dine_drop/pages/widget/support_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: Get.height / 2.5,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                  Color(0xFFff5c30),
                  Color(0xFFe74b1a),
                ])),
            child: Text('Quick Looding'),
          ),
          Container(
            margin: EdgeInsets.only(top: Get.height / 2.8),
            width: double.infinity,
            height: Get.height,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30))),
            child: Padding(
              padding: EdgeInsets.only(top: Get.height / 3),
              child: InkWell(
                onTap: (){
                  Get.to(()=>SignUpPage());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: AppSupportWidget.mediumTextStyle(),
                    ),
                    Text(
                      " Sign Up",
                      style: AppSupportWidget.mediumTextStyle(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: Get.height / 1.5,
            child: Card(
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
                child: Column(
                  children: [
                    Text(
                      'Login',
                      style: AppSupportWidget.boldTextStyle(),
                    ),
                    SizedBox(
                      height: Get.height / 30,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintStyle: AppSupportWidget.mediumTextStyle(),
                        hintText: 'Email',
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                    ),
                    SizedBox(
                      height: Get.height / 30,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintStyle: AppSupportWidget.mediumTextStyle(),
                        hintText: 'Password',
                        prefixIcon: Icon(Icons.password_outlined),
                      ),
                    ),
                    SizedBox(
                      height: Get.height / 40,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        'Forget Password?',
                        style: AppSupportWidget.mediumTextStyle(),
                      ),
                    ),
                    SizedBox(
                      height: Get.height / 30,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFff5c30),
                            padding: EdgeInsets.symmetric(
                                horizontal: Get.width / 8,
                                vertical: Get.height / 85)),
                        onPressed: () {

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
    );
  }
}
