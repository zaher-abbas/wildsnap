import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class PostService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImage(XFile image, String postId) async {
    try {
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final fileName = '$timestamp.jpg';
      final storageRef = _storage.ref().child('posts/$postId/$fileName');
      UploadTask uploadTask;

      if (kIsWeb) {
        final bytes = await image.readAsBytes();
        uploadTask = storageRef.putData(
          bytes,
          SettableMetadata(
            contentType: 'image/jpeg',
            customMetadata: {'uploaded-by': 'wildsnap-web'},
          ),
        );
      } else {
        final file = File(image.path);
        uploadTask = storageRef.putFile(
          file,
          SettableMetadata(
            contentType: 'image/jpeg',
            customMetadata: {'uploaded-by': 'wildsnap-mobile'},
          ),
        );
      }

      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Erreur lors de l\'upload de l\'image: $e');
      rethrow;
    }
  }

  Future<void> createPost({
    required String animalName,
    required String location,
    String? description,
    required XFile image,
    String? userId,
  }) async {
    try {
      final docRef = _firestore.collection('posts').doc();
      final postId = docRef.id;

      final imageUrl = await uploadImage(image, postId);

      // 2. Créer le document dans Firestore
      await docRef.set({
        'animalName': animalName,
        'location': location,
        'description': description ?? '',
        'imageUrl': imageUrl,
        'userId': userId ?? 'anonymous',
        'createdAt': FieldValue.serverTimestamp(),
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
}