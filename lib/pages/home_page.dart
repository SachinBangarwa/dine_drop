
import 'package:dine_drop/pages/core/food_images.dart';
import 'package:dine_drop/pages/detail_page.dart';
import 'package:dine_drop/pages/widget/support_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool iceCream = false;
  bool burger = false;
  bool fruit = false;
  bool food = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildCategoryButtons(),
                  _buildHorizontalScroll(),
                  _buildFoodCard(
                    imageUrl: FoodImages.veggieTaco,
                    title: 'Veggie Taco',
                    description: 'Happy food cheese',
                    price: 35,
                  ),
                  SizedBox(height: Get.height / 35),
                  _buildFoodCard(
                    imageUrl: FoodImages.organicFood,
                    title: 'Organic Food',
                    description: 'Healthy and Fresh',
                    price: 20,
                  ),
                  SizedBox(height: Get.height / 35),
                  _buildFoodCard(
                    imageUrl: FoodImages.veggieTaco,
                    title: 'Veggie Taco',
                    description: 'Tasty and Delicious',
                    price: 30,
                  ),
                  SizedBox(height: Get.height / 35),
                  _buildFoodCard(
                    imageUrl: FoodImages.organicFood,
                    title: 'Organic Food',
                    description: 'Healthy and Fresh',
                    price: 20,
                  ),
                ],
              ),
            ),
          ],
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
              Text('Hello Sonu,', style: AppSupportWidget.boldTextStyle()),
              Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.black,
                ),
                child: Icon(
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
        _buildCategoryButton('images/ice-cream.png', () {
          _selectCategory('iceCream');
        }, isSelected: iceCream),
        _buildCategoryButton('images/food.png', () {
          _selectCategory('food');
        }, isSelected: food),
        _buildCategoryButton('images/burger.png', () {
          _selectCategory('burger');
        }, isSelected: burger),
        _buildCategoryButton('images/fruit.png', () {
          _selectCategory('fruit');
        }, isSelected: fruit),
      ],
    );
  }

  Widget _buildCategoryButton(String imagePath, VoidCallback onTap,
      {required bool isSelected}) {
    return InkWell(
      onTap: onTap,
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

  void _selectCategory(String category) {
    setState(() {
      iceCream = category == 'iceCream';
      burger = category == 'burger';
      fruit = category == 'fruit';
      food = category == 'food';
    });
  }

  Widget _buildHorizontalScroll() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 20),
        child: Row(
          children: [
            _buildHorizontalCard(
                imageUrl: FoodImages.veggieTaco,
                title: 'Veggie Taco Hash',
                description: 'Fresh and Healthy',
                price: 35,
                onTab: () {
                  Get.to(() =>
                      DetailPage(imageUrl: FoodImages.veggieTaco,
                          title: 'Veggie Taco Hash',
                          description: 'Fresh and Healthy',
                          price: 35, ));
                }
            ),
            SizedBox(width: Get.width / 35),
            _buildHorizontalCard(
                imageUrl: FoodImages.organicFood,
                title: 'Organic Food',
                description: 'Fresh and Healthy',
                price: 20,
                onTab: () {
                  Get.to(() =>   const DetailPage(
                    imageUrl: FoodImages.organicFood,
                    title: 'Organic Food',
                    description: 'Fresh and Healthy',
                    price: 20, ));
                }
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHorizontalCard({
    required String imageUrl,
    required String title,
    required String description,
    required double price,
    required VoidCallback onTab,
  }) {
    return InkWell(
      focusColor: Colors.teal,
      highlightColor: Colors.teal.withOpacity(0.2),
      splashColor: Colors.teal,
      borderRadius: BorderRadius.circular(10),
      onTap: onTab,
      child: Card(
        color: Colors.white,
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  imageUrl,
                  height: 150,
                  width: 150,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: Get.height / 80),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppSupportWidget.mediumTextStyle()),
                  Text(description,
                      style: AppSupportWidget.mediumLightBoldTextStyle(),maxLines: 1,overflow: TextOverflow.ellipsis,),
                  Text('\$ $price', style: AppSupportWidget.mediumTextStyle()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFoodCard({
    required String imageUrl,
    required String title,
    required String description,
    required double price,
  }) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                imageUrl,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: Get.width / 20),
            SizedBox(
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppSupportWidget.mediumTextStyle(),
                      maxLines: 2),
                  Text(description,
                      style: AppSupportWidget.mediumLightBoldTextStyle(),
                      maxLines: 2),
                  Text('\$ $price', style: AppSupportWidget.mediumTextStyle()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

