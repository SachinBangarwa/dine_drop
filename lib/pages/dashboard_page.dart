import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dine_drop/pages/home_page.dart';
import 'package:dine_drop/pages/order_page.dart';
import 'package:dine_drop/pages/profile_page.dart';
import 'package:dine_drop/pages/wallet_page.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final List<Widget> pages = [
    const HomePage(),
          OrderPage(),
          WalletPage(),
     const ProfilePage()
  ];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        animationDuration: const Duration(milliseconds: 600),
        backgroundColor: Colors.white,
        color: Colors.black,
        height:65,
        items: const [
          Icon(Icons.home_outlined,color: Colors.white,size: 30,),
          Icon(Icons.shopping_bag_outlined,color: Colors.white,size: 30,),
          Icon(Icons.wallet_outlined,color: Colors.white,size: 30,),
          Icon(Icons.person,color: Colors.white,size: 30,),
        ],
      ),
      body: pages[currentIndex],
    );
  }
}
