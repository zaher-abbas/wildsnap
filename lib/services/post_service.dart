import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class PostService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  /// Upload l'image vers Firebase Storage
  Future<String> uploadImage(XFile image, String postId) async {
    try {
      // Référence vers le fichier dans Storage
      final storageRef = _storage.ref().child('posts/$postId/${image.name}');

      // Upload différent selon la plateforme
      if (kIsWeb) {
        // Sur Web : upload depuis les bytes
        final bytes = await image.readAsBytes();
        await storageRef.putData(
          bytes,
          SettableMetadata(contentType: 'image/jpeg'),
        );
      } else {
        // Sur Mobile : upload depuis le fichier
        final file = File(image.path);
        await storageRef.putFile(file);
      }

      // Récupérer l'URL de téléchargement
      final downloadUrl = await storageRef.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Erreur lors de l\'upload de l\'image: $e');
      rethrow;
    }
  }

  /// Créer un nouveau post dans Firestore
  Future<void> createPost({
    required String animalName,
    required String location,
    required String description,
    required XFile image,
    String? userId, // Optionnel si vous utilisez Firebase Auth
  }) async {
    try {
      // Créer un nouveau document avec un ID auto-généré
      final docRef = _firestore.collection('posts').doc();
      final postId = docRef.id;

      // 1. Upload de l'image
      final imageUrl = await uploadImage(image, postId);

      // 2. Créer le document dans Firestore
      await docRef.set({
        'animalName': animalName,
        'location': location,
        'description': description,
        'imageUrl': imageUrl,
        'userId': userId ?? 'anonymous',
        'createdAt': FieldValue.serverTimestamp(),
        'likes': 0,
      });

      print('Post créé avec succès: $postId');
    } catch (e) {
      print('Erreur lors de la création du post: $e');
      rethrow;
    }
  }

  /// Récupérer tous les posts (pour affichage)
  Stream<QuerySnapshot> getPosts() {
    return _firestore
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  /// Supprimer un post
  Future<void> deletePost(String postId, String imageUrl) async {
    try {
      // Supprimer l'image du Storage
      final ref = _storage.refFromURL(imageUrl);
      await ref.delete();

      // Supprimer le document Firestore
      await _firestore.collection('posts').doc(postId).delete();

      print('Post supprimé avec succès');
    } catch (e) {
      print('Erreur lors de la suppression: $e');
      rethrow;
    }
  }
}