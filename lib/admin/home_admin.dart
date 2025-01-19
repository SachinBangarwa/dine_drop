import 'package:dine_drop/admin/add_food.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../pages/widget/support_widget.dart';

class HomeAdmin extends StatelessWidget {
  const HomeAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              child: Text(
                "Home Admin",
                style: AppSupportWidget.boldTextStyle(),
              ),
            ),
            SizedBox(
              height: Get.height / 20,
            ),
            InkWell(
              onTap: () {
                Get.to(() => const AddFood());
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 2,
                      )
                    ],
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Image.asset(
                      'images/mexican-beef-taco.jpg',
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      width: Get.width / 10,
                    ),
                    const Text(
                      'Add Food Items',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontSize: 16),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
