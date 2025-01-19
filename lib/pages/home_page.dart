import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dine_drop/pages/detail_page.dart';
import 'package:dine_drop/pages/widget/support_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/fetch_food_controller.dart';
import 'core/user_name_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FetchFoodController allFetchFoodController = Get.put(FetchFoodController());

  String selectedCategory = 'ice-cream';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(bottom: 30),
              children: [
                _buildCategoryButtons(),
                _buildHorizontalScroll(),
                _buildVerticalScroll(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  StreamBuilder<QuerySnapshot<Map<String, dynamic>>> _buildVerticalScroll() {
    return StreamBuilder(
      stream: allFetchFoodController.fetchVerticalFood(selectedCategory),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: SizedBox(),
          );
        }
        if (snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text('No items found in this category!'),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.only(top: 10),
          reverse: true,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final doc = snapshot.data!.docs[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: _buildVerticalFoodCard(
                title: doc['itemName'],
                description: doc['itemDetail'],
                price: doc['itemPrice'],
                imageUrl: doc['imageUrl'],
                onTab: () {
                  Get.to(() => DetailPage(
                        imageUrl: doc['imageUrl'],
                        title: doc['itemName'],
                        description: doc['itemDetail'],
                        price: doc['itemPrice'],
                      ));
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildVerticalFoodCard({
    required String imageUrl,
    required String title,
    required String description,
    required String price,
    required VoidCallback onTab,
  }) {
    return InkWell(
      highlightColor: Colors.white,
      onTap: onTab,
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(backgroundColor: Colors.teal.shade500,
                  radius: 50,
                  backgroundImage: NetworkImage(
                    imageUrl,
                  )),
              SizedBox(width: Get.width / 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: AppSupportWidget.mediumTextStyle(), maxLines: 2),
                    Text(description,
                        style: AppSupportWidget.mediumLightBoldTextStyle(),
                        maxLines: 2),
                    Text('\$$price', style: AppSupportWidget.mediumTextStyle()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 12, right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Hello ${UserNameHandler.getNameFromEmail()},',
                  style: AppSupportWidget.boldTextStyle()),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.black,
                ),
                child: const Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),
          SizedBox(height: Get.height / 35),
          Text('Delicious Food',
              style: AppSupportWidget.headLineBoldTextStyle()),
          Text('Discover and get great Food',
              style: AppSupportWidget.lightBoldTextStyle()),
          SizedBox(height: Get.height / 35),
        ],
      ),
    );
  }

  Widget _buildCategoryButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildCategoryButton('ice-cream', 'images/ice-cream.png'),
        _buildCategoryButton('food', 'images/food.png'),
        _buildCategoryButton('burger', 'images/burger.png'),
        _buildCategoryButton('fruit', 'images/fruit.png'),
      ],
    );
  }

  Widget _buildCategoryButton(String category, String imagePath) {
    bool isSelected = selectedCategory == category;
    return InkWell(
      onTap: () {
        setState(() {
          selectedCategory = category;
        });
      },
      child: Material(
        color: isSelected ? Colors.black : Colors.white,
        elevation: 5,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            imagePath,
            color: isSelected ? Colors.white : Colors.black,
            height: 40,
            width: 40,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildHorizontalScroll() {
    return StreamBuilder(
      stream: allFetchFoodController.fetchHorizontalFood(selectedCategory),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: SizedBox(),
          );
        }
        if (snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text('No items found in this category!'),
          );
        }
        return SizedBox(
          height: Get.height / 3,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final doc = snapshot.data!.docs[index];
              return Padding(
                padding: const EdgeInsets.only(
                    left: 12, top: 14, bottom: 14, right: 8),
                child: SizedBox(
                  width: 175,
                  child: _buildHorizontalCard(
                    imageUrl: doc['imageUrl'],
                    title: doc['itemName'],
                    description: doc['itemDetail'],
                    price: doc['itemPrice'],
                    onTab: () {
                      Get.to(() => DetailPage(
                            imageUrl: doc['imageUrl'],
                            title: doc['itemName'],
                            description: doc['itemDetail'],
                            price: doc['itemPrice'],
                          ));
                    },
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildHorizontalCard({
    required String imageUrl,
    required String title,
    required String description,
    required String price,
    required VoidCallback onTab,
  }) {
    return InkWell(
      focusColor: Colors.teal,
      highlightColor: Colors.teal.withOpacity(0.2),
      splashColor: Colors.teal,
      borderRadius: BorderRadius.circular(10),
      onTap: onTab,
      child: Card(
        margin: EdgeInsets.zero,
        color: Colors.white,
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  height: 150,
                  width: 150,
                  imageUrl: imageUrl,
                  alignment: Alignment.topRight,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const ColoredBox(
                    color: Colors.white,
                    child: Center(
                      child: CupertinoActivityIndicator(),
                    ),
                  ),
                  errorWidget: (context, error, ab) =>
                      const Icon(Icons.image_not_supported),
                ),
              ),
              SizedBox(height: Get.height / 80),
              Text(
                title,
                maxLines: 1,
                style: AppSupportWidget.mediumTextStyle(),
              ),
              Text(
                description,
                style: AppSupportWidget.mediumLightBoldTextStyle(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                '\$$price',
                style: AppSupportWidget.mediumTextStyle(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
