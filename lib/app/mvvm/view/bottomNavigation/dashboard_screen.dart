import 'package:flutter/material.dart';
import 'package:frame_wise/app/mvvm/view/bottomNavigation/app_bottom_navigatoin.dart';
import 'package:frame_wise/app/mvvm/view/subscription/subscription_screen.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int currentIndex = 0;

  final List<Widget> pages = [
    const Center(child: Text("Home")),
    const Center(child: Text("Import")),
     // const Center(child: Text("Project")), 
     SubscriptionScreen(), 
    const Center(child: Text("Settings")),
  ];
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: AppBottomNavigation(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}