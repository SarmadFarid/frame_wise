import 'package:flutter/material.dart';
import 'package:frame_wise/app/mvvm/view/bottomNavigation/bottom_navigatoin_widget.dart';
import 'package:frame_wise/app/mvvm/view/settings/settting_screen.dart';

class AppBottomNavigation extends StatefulWidget {
  const AppBottomNavigation({Key? key}) : super(key: key);

  @override
  State<AppBottomNavigation> createState() => _AppBottomNavigationState();
}

class _AppBottomNavigationState extends State<AppBottomNavigation> {
  int currentIndex = 0;

  final List<Widget> pages = [
    const Center(child: Text("Home")),
    const Center(child: Text("Import")),
    const Center(child: Text("Project")),
    SettingScreen()
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