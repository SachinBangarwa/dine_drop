import 'package:dine_drop/auth/sign_up_page.dart';
import 'package:dine_drop/controllers/forgot_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});

  final _forgotController = Get.put(ForgotController());
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 80),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Password Recovery',
                style: TextStyle(
                    fontSize: 20, fontFamily: 'Poppins', color: Colors.white),
              ),
              SizedBox(
                height: Get.height / 50,
              ),
              const Text(
                'Enter your mail',
                style: TextStyle(
                    fontSize: 16, fontFamily: 'Poppins', color: Colors.white),
              ),
              SizedBox(
                height: Get.height / 15,
              ),
              SizedBox(
                height: Get.height / 10,
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter the correct email';
                    }
                    return null;
                  },
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                      fontFamily: "Poppins", color: Colors.grey.shade500),
                  decoration: InputDecoration(contentPadding: EdgeInsets.zero,
                      hintText: 'Email',
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2))),
                ),
              ),
              SizedBox(
                height: Get.height / 45,
              ),
              InkWell(
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    await _onTabHandlerForget();
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: 45,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: const Text(
                    'Send Email',
                    style: TextStyle(fontFamily: 'Poppins'),
                  ),
                ),
              ),
              SizedBox(
                height: Get.height / 20,
              ),
              GestureDetector(
                onTap: (){
                  Get.offAll(() => SignUpPage());
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style:
                          TextStyle(color: Colors.white, fontFamily: 'Poppins'),
                    ),
                    Text(
                      " Create",
                      style: TextStyle(color: Colors.grey, fontFamily: 'Poppins'),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future _onTabHandlerForget() async {
    await _forgotController.forgetPassword(_emailController.text.trim());
  }
}
