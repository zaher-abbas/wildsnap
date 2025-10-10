import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wildsnap/screens/home_page.dart';
import 'package:wildsnap/services/post_service.dart';
import 'package:wildsnap/widgets/custom_appbar.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  XFile? _image;
  bool _isLoading = false;

  final _animalNameController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _picker = ImagePicker();
  final _postService = PostService();

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

    const imageFit = BoxFit.contain;

    if (kIsWeb) {
      return Image.network(_image!.path, fit: imageFit);
    } else {
      return Image.file(File(_image!.path), fit: imageFit);
    }
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
  }

  Future<void> _submitPost() async {
    if (_animalNameController.text.isEmpty ||
        _locationController.text.isEmpty ||
        _image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Veuillez remplir tous les champs et sélectionner une image.',
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Créer le post via le service
      await _postService.createPost(
        animalName: _animalNameController.text.trim(),
        location: _locationController.text.trim(),
        description: _descriptionController.text.trim(),
        image: _image!,
        userId: FirebaseAuth.instance.currentUser?.uid,
      );

      if (!mounted) return;

      // Succès : afficher un message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Post publié avec succès !'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );

      // Réinitialiser le formulaire
      _animalNameController.clear();
      _locationController.clear();
      _descriptionController.clear();
      setState(() {
        _image = null;
      });

      // Attendre un peu puis naviguer vers la home
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return;
      _navigateToHome();

    } catch (e) {
      if (!mounted) return;

      // Erreur : afficher un message d'erreur
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur lors de la publication: $e'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: _buildImagePreview(),
                ),
                const SizedBox(height: 24),

                // Boutons pour caméra et galerie
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                      onPressed: _isLoading ? null : () => _pickImage(ImageSource.camera),
                      backgroundColor: _isLoading ? Colors.grey : Colors.green,
                      heroTag: 'camera_button',
                      child: const Icon(Icons.camera_alt, color: Colors.white),
                    ),
                    const SizedBox(width: 32),
                    FloatingActionButton(
                      onPressed: _isLoading ? null : () => _pickImage(ImageSource.gallery),
                      backgroundColor: _isLoading ? Colors.grey : Colors.green,
                      heroTag: 'gallery_button',
                      child: const Icon(Icons.photo_library, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Formulaire
                TextField(
                  controller: _animalNameController,
                  enabled: !_isLoading,
                  decoration: const InputDecoration(
                    labelText: "Nom de l'animal",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _locationController,
                  enabled: !_isLoading,
                  decoration: const InputDecoration(
                    labelText: 'Localisation',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _descriptionController,
                  enabled: !_isLoading,
                  decoration: const InputDecoration(
                    labelText: 'Description (optionnel)',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 32),

                // Bouton Post
                ElevatedButton(
                  onPressed: _isLoading ? null : _submitPost,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                      : const Text('Poster'),
                ),
              ],
            ),
          ),

          // Overlay de chargement (par-dessus tout)
          if (_isLoading)
            Container(
              color: Colors.black38,
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }
}