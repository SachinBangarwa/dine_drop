import 'package:dine_drop/pages/widget/support_widget.dart';
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
  final dynamic price;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 60, left: 18, right: 18, bottom: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.arrow_back_ios_new,
                size: 26,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      widget.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: Get.height / 90),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 200,
                        child: Text(
                          widget.title,
                          style: AppSupportWidget.boldTextStyle(),
                        ),
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (quantity > 1) quantity--;
                              });
                            },
                            child: Material(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              color: Colors.black,
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Icon(
                                  Icons.remove_rounded,
                                  color: Colors.white,
                                ),
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
                              });
                            },
                            child: Material(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              color: Colors.black,
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
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
                      Text(
                        'Deliver Time',
                        style: AppSupportWidget.boldTextStyle(),
                      ),
                      SizedBox(width: Get.width / 14),
                      Icon(Icons.alarm),
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
                    Text(
                      '\$${widget.price}',
                      style: AppSupportWidget.boldTextStyle(),
                    ),
                  ],
                ),
                MaterialButton(
                  padding: const EdgeInsets.symmetric(vertical:10,horizontal: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  color: Colors.black,
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Add to card',
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'poppins'),
                      ),
                      const SizedBox(width: 10,),
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
}
