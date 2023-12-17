import 'package:flutter/material.dart';
import 'package:yourest/pages/favorite_page.dart';
import 'package:yourest/pages/home_page.dart';
import 'package:yourest/pages/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List page = [
    const HomePage(),
    const FavoritePage(),
    const ProfilePage(),
  ];

  ///Default selected index bottom navigationbar
  int _currentIndex = 0;
  void onTap(int index) {
    setState(() {});
    _currentIndex = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: page[_currentIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          onTap: onTap,
          currentIndex: _currentIndex,
          backgroundColor: const Color(0xff477680),
          selectedItemColor: const Color(0xffefefef),
          unselectedItemColor: const Color(0xffa6a6a6),
          elevation: 0,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline_outlined),
              label: 'Favorite',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Profile',
            )
          ],
        ),
      ),
    );
  }
}
