import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/Coupon.dart';
import '../models/PurchasedCoupon.dart';

class UserProvider with ChangeNotifier {
  final databaseReference = FirebaseFirestore.instance;
  String _id = '';
  String _name = '';
  int _points = 0;
  // List<PurchasedCoupon> _myCoupons = [];
  // List<PurchasedCoupon> _usedCoupons = [];
  List<Coupon> _myCoupons = [];
  List<Coupon> _usedCoupons = [];

  UserProvider() {
    getUserName();
    getUserId();
    getUserCoupons();
    getUserUsedCoupons();
  }

  void getUserName() {}

  void getUserId() {}

  void getUserCoupons() {}

  void getUserUsedCoupons() {}

  void addUserPoints(int points) {
    _points = _points + points;
    notifyListeners();
  }

  void subtractUserPoints(int points) {
    _points = _points - points;
    notifyListeners();
  }

  String get id {
    return _id;
  }

  String get name {
    return _name;
  }

  int get points {
    return _points;
  }

  List<Coupon> get myCoupons {
    return _myCoupons;
  }

  List<Coupon> get myUsedCoupons {
    return _usedCoupons;
  }

  bool get isAuth {
    return _name != '';
  }
  // List<PurchasedCoupon> get myCoupons {
  //   return _myCoupons;
  // }

  // List<PurchasedCoupon> get myUsedCoupons {
  //   return _usedCoupons;
  // }
}

// // factory User.fromFirestore(DocumentSnapshot doc) {
// //     Map data = doc.data();
// //     return User(
// //         id: doc.id,
// //         name: data['name'] ?? '',
// //         points: data['points'] ?? 0,
// //         myCoupons: []); //DUMMY_PURCHASED_COUPONS);
// //   }
// //   factory User.fromMap(Map data) {
// //     data = data ?? {};
// //     return User(
// //         id: data['id'] ?? '',
// //         name: data['name'] ?? '',
// //         points: data['points'] ?? 0,
// //         myCoupons: []); // DUMMY_PURCHASED_COUPONS);
// //   }
