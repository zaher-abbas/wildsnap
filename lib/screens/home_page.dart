import 'package:flutter/material.dart';
import 'package:wildsnap/widgets/custom_appbar.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Home',),
      body: const Center(child: Text('Welcome to WildSnap!'))
    );
  }
}
