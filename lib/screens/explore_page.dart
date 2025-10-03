import 'package:flutter/material.dart';
import 'package:wildsnap/widgets/custom_appbar.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Explore'),
      body: const Center(child: Text('Explore here')),
    );
  }
}
