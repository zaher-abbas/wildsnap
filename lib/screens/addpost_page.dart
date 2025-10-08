import 'dart:io'; // Import pour utiliser la classe File
import 'package:flutter/foundation.dart'
    show kIsWeb; // Pour la compatibilité web
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Import du package
import 'package:wildsnap/widgets/custom_appbar.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  XFile? _image;

  final _animalNameController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _picker = ImagePicker();

  @override
  void dispose() {
    _animalNameController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
      });
    }
  }

  Widget _buildImagePreview() {
    if (_image == null) {
      return Center(
        child: Icon(
          Icons.image_outlined,
          color: Colors.grey[600],
          size: 60,
        ),
      );
    }

    if (kIsWeb) {
      // Sur le web, on utilise Image.network
      return Image.network(_image!.path, fit: BoxFit.cover);
    } else {
      // Sur mobile, on utilise Image.file
      return Image.file(File(_image!.path), fit: BoxFit.cover);
    }
  }

  void _submitPost() {
    if (_animalNameController.text.isEmpty ||
        _locationController.text.isEmpty ||
        _image == null) {
      print("Erreur : Tous les champs et l'image sont requis.");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Veuillez remplir tous les champs et sélectionner une image.',
          ),
        ),
      );
      return;
    }

    print('Nom: ${_animalNameController.text}');
    print('Localisation: ${_locationController.text}');
    print('Description: ${_descriptionController.text}');
    print('Chemin de l\'image: ${_image?.path}');
    print('Publication en cours...');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Nouvelle Publication'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.width /2,
                width: MediaQuery.of(context).size.width /2,
                child: _buildImagePreview(),
              ),
            const SizedBox(height: 24),

            // --- Boutons pour caméra et galerie ---
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Bouton Caméra
                FloatingActionButton(
                  onPressed: () => _pickImage(ImageSource.camera),
                  backgroundColor: Colors.green,
                  heroTag: 'camera_button',
                  child: const Icon(Icons.camera_alt, color: Colors.white),
                ),
                const SizedBox(width: 32),
                // Bouton Galerie
                FloatingActionButton(
                  onPressed: () => _pickImage(ImageSource.gallery),
                  backgroundColor: Colors.green,
                  heroTag: 'gallery_button',
                  child: const Icon(Icons.photo_library, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // --- Formulaire ---
            TextField(
              controller: _animalNameController,
              decoration: const InputDecoration(
                labelText: "Nom de l'animal",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _locationController,
              decoration: const InputDecoration(
                labelText: 'Localisation',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description (optionnel)',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 32),

            // --- Bouton Post ---
            ElevatedButton(
              onPressed: _submitPost,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text('Poster'),
            ),
          ],
        ),
      ),
    );
  }
}
