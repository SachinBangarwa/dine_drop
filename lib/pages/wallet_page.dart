import 'dart:convert';
import 'package:dine_drop/pages/widget/support_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class WalletPage extends StatelessWidget {
  WalletPage({super.key});

  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 45),
            child: Align(
                child: Text(
              'Wallet',
              style: AppSupportWidget.boldTextStyle(),
            )),
          ),
          Divider(
            thickness: 1.5,
            color: Colors.grey.withOpacity(0.6),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.all(4),
            color: const Color(0x33D2BAB4),
            child: Row(
              children: [
                Image.asset(
                  'images/wallet.png',
                  fit: BoxFit.cover,
                  height: 50,
                ),
                SizedBox(
                  width: Get.width / 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Wallet',
                      style: AppSupportWidget.mediumLightBoldTextStyle(),
                    ),
                    Text(
                      '\$100',
                      style: AppSupportWidget.mediumTextStyle(),
                    ),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 14, top: 10, bottom: 14),
            child: Text(
              'Add money',
              style: AppSupportWidget.mediumTextStyle(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300)),
                child: Text(
                  '\$100',
                  style: AppSupportWidget.mediumTextStyle(),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300)),
                child: Text(
                  '\$500',
                  style: AppSupportWidget.mediumTextStyle(),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300)),
                child: Text(
                  '\$1000',
                  style: AppSupportWidget.mediumTextStyle(),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300)),
                child: Text(
                  '\$20000',
                  style: AppSupportWidget.mediumTextStyle(),
                ),
              ),
            ],
          ),
          SizedBox(
            height: Get.height / 11,
          ),
          GestureDetector(
            onTap: () {
              _onShowDialogBoxWithField(context);
              makePayment();
            },
            child: Container(
              width: Get.width,
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 14),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(6)),
              child: const Text(
                'Add money',
                style: TextStyle(fontFamily: 'Poppins', color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onShowDialogBoxWithField(context) {
    showDialog(
        context: context,
        builder: (
          context,
        ) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(color: Colors.grey)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            content: SizedBox(
              height: Get.height / 3.8,
              child: ListView(
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: const CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.black,
                          child: Center(
                            child: Icon(
                              Icons.cancel_rounded,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: Get.width / 10,
                      ),
                      Text(
                        'Add Money',
                        style: AppSupportWidget.boldTextStyle(),
                      )
                    ],
                  ),
                  SizedBox(
                    height: Get.height / 60,
                  ),
                  const Text(
                    'Amount',
                    style:
                        TextStyle(color: Colors.black, fontFamily: 'Poppins'),
                  ),
                  SizedBox(
                    height: Get.height / 80,
                  ),
                  SizedBox(
                    height: Get.height / 15,
                    child: TextFormField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          hintText: 'Enter Amount',
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                  SizedBox(
                    height: Get.height / 60,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: MaterialButton(
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      onPressed: () {
                        Get.back();
                        makePayment();
                      },
                      child: const Text(
                        'Pay',
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'Poppins'),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<void> makePayment() async {
    try {
      final response = await http.post(
        Uri.parse('http://api.stripe.com/v1/payment-intents'),
        body: jsonEncode({
          'amount': '500',
          'currency': 'INR',
          'payment_method_types[]': 'card'
        }),
        headers: {
          'Authorization':
              'Bearer sk_test_51QhSPeBujAXMH72FfK6uAzoFBcpYs3Hkjj0wCGTuiPlzyuluwN6qBuD6UCPO1dZxW7hoPKRhMF7GVb5feNDUoWx200Qb1Azatq',
          'Content-Type': 'application/json'
        },
      );

      final jsonResponse = jsonDecode(response.body);

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: jsonResponse[
              'sk_test_51QhSPeBujAXMH72FfK6uAzoFBcpYs3Hkjj0wCGTuiPlzyuluwN6qBuD6UCPO1dZxW7hoPKRhMF7GVb5feNDUoWx200Qb1Azatq'],
          merchantDisplayName: 'Dine Drop',
        ),
      );

      await Stripe.instance.presentPaymentSheet();

      print('Payment Successful!');
    } catch (e) {
      print('Payment Failed: $e');
    }
  }
}
