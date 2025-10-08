import 'package:flutter/material.dart';

// import 'package:wildsnap/widgets/camera_page.dart'; // Ce n'est plus nécessaire ici
import 'package:wildsnap/widgets/custom_appbar.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  final _animalNameController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _animalNameController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _openCamera() {
    print('Ouverture de la caméra...');
  }

  void _openGallery() {
    print('Ouverture de la galerie...');
  }

  void _submitPost() {
    print('Nom: ${_animalNameController.text}');
    print('Localisation: ${_locationController.text}');
    print('Description: ${_descriptionController.text}');
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
            Container(
              height: 250,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Icon(
                  Icons.image_outlined,
                  color: Colors.grey[600],
                  size: 60,
                ),
              ),
            ),
            const SizedBox(height: 24),
            // --- Boutons pour caméra et galerie ---
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Bouton Caméra
                FloatingActionButton(
                  onPressed: _openCamera,
                  backgroundColor: Colors.green,
                  heroTag: 'camera_button',
                  child: const Icon(Icons.camera_alt, color: Colors.white),
                ),
                const SizedBox(width: 32),
                // Bouton Galerie
                FloatingActionButton(
                  onPressed: _openGallery,
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
              maxLines: 3, // Pour un champ de texte plus grand
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
