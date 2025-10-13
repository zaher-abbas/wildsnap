import 'package:flutter/material.dart';
import 'package:wildsnap/widgets/custom_appbar.dart';
import 'package:wildsnap/widgets/random_catfact.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Home',),
      body: SingleChildScrollView(
          child: Column(
            children: [
              RandomCatfact(),
          Container(),
        ],
      ),
      ),
    );
  }
}
