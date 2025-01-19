import 'package:dine_drop/pages/widget/on_board_model.dart';
import 'package:dine_drop/pages/widget/support_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardMessage extends StatelessWidget {
  const OnBoardMessage({super.key, required this.content});
  final OnBoardModel content;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 45,),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              content.imageUrl,
              width: 300,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: Get.height / 30,
            ),
            Text(
              content.title,
              style: AppSupportWidget.boldTextStyle(),
            ),
            SizedBox(
              height: Get.height / 30,
            ),
            Text(
              content.description,
              style: AppSupportWidget.lightBoldTextStyle(),
            ),
            SizedBox(
              height: Get.height / 20,
            ),
          ],
        ),
      ),
    );
  }
}
