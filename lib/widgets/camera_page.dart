import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  XFile? pickedImage;

  final picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        pickedImage = pickedFile;
      });
    }
  }

  Widget _buildImageWidget() {
    if (pickedImage == null) {
      return const Center(child: Text('No image selected'));
    }

    if (kIsWeb) {
      // Sur le web, on utilise Image.network
      return Image.network(pickedImage!.path);
    } else {
      // Sur mobile, on utilise Image.file
      return Image.file(File(pickedImage!.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 150,
          width: 150,
          child: _buildImageWidget(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(24),
                backgroundColor: Colors.green[800],
              ),
              onPressed: () => pickImage(ImageSource.camera),
              child: const Icon(
                Icons.photo_camera,
                color: Colors.white,
                size: 34,
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(24),
                backgroundColor: Colors.green[800],
              ),
              onPressed: () => pickImage(ImageSource.gallery),
              child: const Icon(
                Icons.photo_library,
                color: Colors.white,
                size: 34,
              ),
            ),
          ],
        ),
      ],
    );
  }
}