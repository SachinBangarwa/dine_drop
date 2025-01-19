import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dine_drop/controllers/fetch_cart_controller.dart';
import 'package:dine_drop/pages/widget/support_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderPage extends StatelessWidget {
  OrderPage({super.key});

  final FetchCartController fetchCartController =
      Get.put(FetchCartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildAppBar(),
          Divider(
            thickness: 1.5,
            color: Colors.grey.withOpacity(0.6),
          ),
          Expanded(
            child: _buildStreamBuilderCart(),
          ),
          Divider(
            thickness: 1.5,
            color: Colors.grey.withOpacity(0.6),
          ),
          _buildBottomSheetCheckOut(),
        ],
      ),
    );
  }
  Padding _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 45),
      child: Align(
        child: Text(
          'Food Cart',
          style: AppSupportWidget.boldTextStyle(),
        ),
      ),
    );
  }

  Widget _buildStreamBuilderCart() {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: fetchCartController.fetchFoodSnapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        }
        if (snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text('No items found in this category!'),
          );
        }

        WidgetsBinding.instance.addPostFrameCallback((collBack){
          fetchCartController.calculateTotal(snapshot.data!);
        });

        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final doc = snapshot.data!.docs[index];
            return SizedBox(
              width: Get.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 12),
                    child: Row(
                      children: [
                        Container(
                          height: 70,
                          width: 30,
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            doc['quantity'].toString(),
                            style: AppSupportWidget.mediumTextStyle(),
                          ),
                        ),
                        SizedBox(width: Get.width / 20),
                        CircleAvatar(
                          radius: 45,
                          backgroundColor: Colors.teal.shade500,
                          backgroundImage: NetworkImage(
                            doc['imageUrl'],
                          ),
                        ),
                        SizedBox(width: Get.width / 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              doc['itemName'],
                              style: AppSupportWidget.mediumTextStyle(),
                            ),
                            Text(
                              '\$${doc['total']}',
                              style: AppSupportWidget.mediumTextStyle(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildBottomSheetCheckOut() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: 14.0,
              left: 10,
              right: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Price',
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
                ),
                Obx(
                  () => Text(
                    '\$${fetchCartController.total.value}',
                    style: AppSupportWidget.mediumTextStyle(),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              // Checkout logic here
            },
            child: Container(
              width: Get.width,
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 14),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(6)),
              child: const Text(
                'Check Out',
                style: TextStyle(fontFamily: 'Poppins', color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }

}
