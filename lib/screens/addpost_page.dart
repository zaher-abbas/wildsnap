import 'package:flutter/material.dart';
import 'package:wildsnap/widgets/camera_page.dart';
import 'package:wildsnap/widgets/custom_appbar.dart';

class AddPostPage extends StatelessWidget {
  const AddPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Explore'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 300,
              height: 400,
            ),
            CameraPage(),
          ],
        ),
      ),
    );
  }
}
