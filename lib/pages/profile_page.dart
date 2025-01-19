import 'dart:io';
import 'package:dine_drop/auth/log_in_page.dart';
import 'package:dine_drop/auth/sign_up_page.dart';
import 'package:dine_drop/pages/widget/support_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'core/user_name_handler.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: Get.height / 3.8,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.vertical(
                      bottom: Radius.elliptical(Get.width, 105)),
                ),
                alignment: Alignment.center,
                child: Text(
                  UserNameHandler.getNameFromEmail(),
                  style: const TextStyle(
                      color: Colors.white, fontSize: 22, fontFamily: 'Poppins'),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: Get.height / 5.5),
                child: Center(
                  child: path == null
                      ? GestureDetector(
                          onTap: () {
                            _onTabGetImage();
                          },
                          child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(60)),
                              elevation: 10,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(60),
                                  child: Image.asset(
                                    'images/boy.jpg',
                                    fit: BoxFit.cover,
                                    height: 120,
                                    width: 120,
                                  ))),
                        )
                      : Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(60)),
                          elevation: 10,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: Image.file(
                              File(path!),
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                          )),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.person,
                      size: 28,
                    ),
                    SizedBox(
                      width: Get.width / 25,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name',
                          style: AppSupportWidget.mediumTextStyle(),
                        ),
                        Text(
                          UserNameHandler.getNameFromEmail().toString(),
                          style: AppSupportWidget.mediumTextStyle(),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.email,
                      size: 26,
                    ),
                    SizedBox(
                      width: Get.width / 25,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email',
                          style: AppSupportWidget.mediumTextStyle(),
                        ),
                        SizedBox(
                          width: Get.width / 1.5,
                          child: Text(
                            UserNameHandler.user.email!.capitalizeFirst.toString(),
                            style: AppSupportWidget.mediumTextStyle(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: InkWell(
              focusColor: Colors.black26,
              highlightColor: Colors.black.withOpacity(0.2),
              splashColor: Colors.black54,
              borderRadius: BorderRadius.circular(10),
              onTap: () {},
              child: Card(
                elevation: 5,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 18.0, horizontal: 8),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.sd_storage,
                        size: 26,
                      ),
                      SizedBox(
                        width: Get.width / 25,
                      ),
                      Text(
                        'Terms And Condition',
                        style: AppSupportWidget.mediumTextStyle(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: InkWell(
              focusColor: Colors.black26,
              highlightColor: Colors.black.withOpacity(0.2),
              splashColor: Colors.black54,
              borderRadius: BorderRadius.circular(10),
              onTap: () async {
                await UserNameHandler.user.delete().then((_) {
                  Get.offAll(() => SignUpPage());
                });
              },
              child: Card(
                elevation: 5,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 18.0, horizontal: 8),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.delete,
                        size: 28,
                      ),
                      SizedBox(
                        width: Get.width / 25,
                      ),
                      Text(
                        'Delete Account',
                        style: AppSupportWidget.mediumTextStyle(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: InkWell(
              focusColor: Colors.black26,
              highlightColor: Colors.black.withOpacity(0.2),
              splashColor: Colors.black54,
              borderRadius: BorderRadius.circular(10),
              onTap: () async {
                await FirebaseAuth.instance.signOut().then((_) {
                  Get.offAll(() => LogInPage());
                });
              },
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 18.0, horizontal: 10),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.logout,
                        size: 28,
                      ),
                      SizedBox(
                        width: Get.width / 25,
                      ),
                      Text(
                        'Log Out',
                        style: AppSupportWidget.mediumTextStyle(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _onTabGetImage() async {
    final ImagePicker imagePicker = ImagePicker();
    final XFile? file =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      setState(() {
        path = file.path;
      });
    }
  }
}
