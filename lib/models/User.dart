import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String id;
  String name;
  int points;

  User({this.id, this.name, this.points});

  factory User.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();
    return User(
      id: doc.id,
      name: data['name'] ?? '',
      points: data['points'] ?? 0,
    );
  }
  factory User.fromMap(Map data) {
    data = data ?? {};
    return User(
      id: data['name'] ?? '',
      name: data['name'] ?? '',
      points: data['points'] ?? 0,
    );
  }
}
