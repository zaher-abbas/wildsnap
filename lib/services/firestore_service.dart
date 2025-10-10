import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Example method to add data
  Future<void> addData(String collection, Map<String, dynamic> data) async {
    await _firestore.collection(collection).add(data);
  }

  // Example method to get data
  Stream<QuerySnapshot> getData(String collection) {
    return _firestore.collection(collection).snapshots();
  }
}
