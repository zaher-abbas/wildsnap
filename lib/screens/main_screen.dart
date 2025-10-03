import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'home_page.dart';
import 'explore_page.dart';
import 'collections_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    ExplorePage(),
    CollectionsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
        bottomNavigationBar: Container(
          color: Colors.green[700],
            child: GNav(
              gap: 4,
              activeColor: Colors.white,
              color: Colors.black,
              backgroundColor: Colors.transparent,
              tabBackgroundColor: Colors.green,
              padding: const EdgeInsets.all(16),
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() => _selectedIndex = index);
              },
              tabs: const [
                GButton(icon: Icons.home, text: 'Home'),
                GButton(icon: Icons.explore, text: 'Explore'),
                GButton(icon: Icons.collections, text: 'Collections'),
              ],
            ),
          ),
        );
  }
}