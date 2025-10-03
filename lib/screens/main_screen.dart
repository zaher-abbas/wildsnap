import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'home_page.dart'; // ton fichier existant
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: GNav(
          gap: 8,
          activeColor: Colors.white,
          color: Colors.grey[600],
          backgroundColor: Colors.white,
          tabBackgroundColor: Colors.deepPurple,
          padding: const EdgeInsets.all(16),
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