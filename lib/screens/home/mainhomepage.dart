import 'package:flutter/material.dart';
import 'package:ptktpm_final_project/screens/home/myhomepage.dart';
import 'package:ptktpm_final_project/screens/user/favorite.dart';
import 'package:ptktpm_final_project/screens/user/information.dart';
import 'package:ptktpm_final_project/screens/user/newsfeed.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  List pages = [
    MyHomePage(),
    NewsFeed(),
    Information(),
    Favorite(),
    Information(),
  ];
  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        unselectedFontSize: 0,
        selectedFontSize: 0,
        type: BottomNavigationBarType.fixed,
        onTap: onTap,
        currentIndex: currentIndex,
        unselectedItemColor: Colors.white,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            label: 'Trang chủ',
            icon: Icon(Icons.home, color: currentIndex == 0 ? Colors.orange : Colors.white),
          ),
          BottomNavigationBarItem(
            label: 'Tin tức',
            icon: Icon(Icons.newspaper, color: currentIndex == 1 ? Colors.yellow : Colors.white),
          ),
          BottomNavigationBarItem(
            label: 'Camera',
            icon: Icon(Icons.camera, color: currentIndex == 2 ? Colors.black : Colors.white),
          ),
          BottomNavigationBarItem(
            label: 'Yêu thích',
            icon: Icon(Icons.favorite, color: currentIndex == 3 ? Colors.redAccent : Colors.white),
          ),
          BottomNavigationBarItem(
            label: 'Cài đặt',
            icon: Icon(Icons.person, color: currentIndex == 4 ? Colors.deepPurple : Colors.white),
          ),
        ],
      ),
    );
  }
}
