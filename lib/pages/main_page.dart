import 'package:flutter/material.dart';

import 'home_page.dart';
import 'profile_page.dart';
import 'assets_page.dart';
import 'voucher_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  static const _hiddenNavIndexes = {2};

  final List<Widget> _pages = const [
    HomePage(),
    AssetsPage(),
    VoucherPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final hideNav = _hiddenNavIndexes.contains(_currentIndex);

    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: hideNav
          ? null
          : BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart_outline),
            label: 'Assets',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.confirmation_number_outlined),
            label: 'Voucher',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}