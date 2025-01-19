import 'package:dine_drop/auth/log_in_page.dart';
import 'package:dine_drop/pages/widget/on_board_message.dart';
import 'package:dine_drop/pages/widget/on_board_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardPage extends StatefulWidget {
  const OnBoardPage({super.key});

  @override
  State<OnBoardPage> createState() => _OnBoardPageState();
}

class _OnBoardPageState extends State<OnBoardPage> {
  late PageController pageController;
  int currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
                itemCount: OnBoardModel.contentList.length,
                controller: pageController,
                onPageChanged: (int value) {
                  currentIndex = value;
                  setState(() {});
                },
                itemBuilder: (context, index) {
                  OnBoardModel content = OnBoardModel.contentList[index];
                  return OnBoardMessage(
                    content: content,
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(OnBoardModel.contentList.length, (value) {
                return _buildContainerDot(value);
              }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 14.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal:
                          currentIndex == OnBoardModel.contentList.length - 1
                              ? Get.width / 3.14
                              : Get.width / 3.10,
                      vertical: Get.height / 70,
                    ),
                    backgroundColor: const Color(0xFFe74b1a),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                onPressed: () {
                  if (currentIndex == OnBoardModel.contentList.length - 1) {
                    Get.offAll(() => LogInPage());
                  }
                  pageController.nextPage(
                      duration: (const Duration(milliseconds: 100)),
                      curve: Curves.bounceIn);
                },
                child: Text(
                  currentIndex == OnBoardModel.contentList.length - 1
                      ? 'Start'
                      : 'Next',
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      wordSpacing: 2.5),
                )),
          )
        ],
      ),
    );
  }

  Container _buildContainerDot(int value) {
    return Container(
      margin: const EdgeInsets.all(4),
      height: 10,
      width: currentIndex == value ? 17 : 10,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: currentIndex == value
              ? Colors.grey.shade600
              : Colors.grey.shade500),
    );
  }
}
