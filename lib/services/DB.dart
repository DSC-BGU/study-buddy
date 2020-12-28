import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_buddy/models/User.dart';
import 'package:study_buddy/models/store.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Get a stream of a single document
  Stream<User> streamUser(String id) {
    return _db
        .collection('users')
        .doc(id)
        .snapshots()
        .map((snap) => User.fromMap(snap.data()));
  }

  Stream storesByCategory(String categoryName) {
    return _db
        .collection('stores')
        .where('category', arrayContains: categoryName)
        .orderBy('name')
        .snapshots();
  }

  /// Write data
  Future<void> updateUserPoints(String id, int points) {
    return _db.collection('users').doc(id).set({"points": points});
  }
}
