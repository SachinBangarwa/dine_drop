import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dine_drop/pages/core/show_toast.dart';
import 'package:dine_drop/pages/widget/support_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailPage extends StatefulWidget {
  const DetailPage(
      {super.key,
      required this.title,
      required this.imageUrl,
      required this.description,
      required this.price});

  final String title;
  final String imageUrl;
  final String description;
  final String price;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int quantity = 1;
  int total = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    total = int.parse(widget.price);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 60, left: 18, right: 18, bottom: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Icons.arrow_back_ios_new,
                size: 28,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                      imageUrl: widget.imageUrl,
                      placeholder: (context, place) =>
                          const Center(child: CupertinoActivityIndicator()),
                      errorWidget: (context, error, ab) =>
                          const Icon(Icons.image_not_supported),
                    ),
                  ),
                  SizedBox(height: Get.height / 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 180,
                        child: Text(
                          widget.title,
                          maxLines: 4,
                          style: const TextStyle(
                              fontFamily: 'Poppins', fontSize: 18),
                        ),
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (quantity > 1) {
                                  quantity--;
                                  total = total - int.parse(widget.price);
                                }
                              });
                            },
                            child: Material(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              color: Colors.black,
                              child: const Icon(
                                Icons.remove_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(width: Get.width / 30),
                          Text(
                            quantity.toString(),
                            style: AppSupportWidget.boldTextStyle(),
                          ),
                          SizedBox(width: Get.width / 30),
                          InkWell(
                            onTap: () {
                              setState(() {
                                quantity++;
                                total = total + int.parse(widget.price);
                              });
                            },
                            child: Material(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              color: Colors.black,
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: Get.height / 90),
                  Text(
                    widget.description,
                    style: AppSupportWidget.lightBoldTextStyle(),
                    textAlign: TextAlign.start,
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                  SizedBox(height: Get.height / 20),
                  Row(
                    children: [
                      const Text(
                        'Deliver Time',
                        style: TextStyle(fontFamily: 'Poppins', fontSize: 18),
                      ),
                      SizedBox(width: Get.width / 14),
                      const Icon(Icons.alarm),
                      SizedBox(width: Get.width / 35),
                      Text(
                        '30 min',
                        style: AppSupportWidget.mediumTextStyle(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Price',
                      style: AppSupportWidget.boldTextStyle(),
                    ),
                    SizedBox(
                      width: Get.width / 2.5,
                      child: Text(
                        '\$${total.toString()}',
                        overflow: TextOverflow.ellipsis,
                        style: AppSupportWidget.boldTextStyle(),
                      ),
                    ),
                  ],
                ),
                MaterialButton(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Colors.black,
                  onPressed: () async {
                    await _onPressAddToCartCloud();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Add to cart',
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'poppins'),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        child: const Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.black,
                          size: 26,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> _onPressAddToCartCloud() async {
    final user = FirebaseAuth.instance.currentUser;
    Map<String, dynamic> data = {
      'imageUrl': widget.imageUrl,
      'itemName': widget.title,
      'total': total,
      'quantity': quantity,
    };
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('cart')
        .add(data)
        .then((onValue) {
      showToast('Add to Cart SuccessFull');
    });
  }
}
