import 'package:flutter/material.dart';
import 'package:wildsnap/widgets/custom_appbar.dart';

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Collections'),
      body: const Center(child: Text('Collections content here')),
    );
  }
}
