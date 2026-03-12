import 'package:flutter/material.dart';
import 'package:frame_wise/app/mvvm/view/bottomNavigation/bottom_navigatoin_widget.dart';
import 'package:frame_wise/app/mvvm/view/home/home_screen.dart';
import 'package:frame_wise/app/mvvm/view/import/import_video_screen.dart';
import 'package:frame_wise/app/mvvm/view/project/project_screen.dart';
import 'package:frame_wise/app/mvvm/view/settings/settting_screen.dart';

class AppBottomNavigation extends StatefulWidget {
  const AppBottomNavigation({super.key});

  @override
  State<AppBottomNavigation> createState() => _AppBottomNavigationState();
}

class _AppBottomNavigationState extends State<AppBottomNavigation> {
  int currentIndex = 0;

  final List<Widget> pages = [
    HomeScreen(),
    ImportVideoScreen(), 
    ProjectListScreen(),
    SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationWidget(
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
