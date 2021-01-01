import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/Coupon.dart';
import '../models/PurchasedCoupon.dart';

class UserProvider with ChangeNotifier {
  // final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String _id = FirebaseAuth.instance.currentUser.uid;
  String _name = '';
  int _points = 500;
  List<Coupon> _usedCoupons = [];
  List<PurchasedCoupon> _purchasedCoupons = [];

  UserProvider() {
    getUserData();
  }

  // //Using Stream to listen to Authentication State
  // Stream<User> get authState => firebaseAuth.idTokenChanges();

  Future<void> getUserData() async {
    // this._id = firebaseAuth.currentUser.uid;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(this._id)
        .get();
    this._name = userData.data()['username'];
    this._points = userData.data()['points'];
    this._usedCoupons = userData.data()['used_coupons'];
    this._purchasedCoupons = userData.data()['purchased_coupons'];
    notifyListeners();
  }

  void addUserPoints(int points) {
    _points += points;
    // this._points = this._points + points;
    FirebaseFirestore.instance
        .collection('users')
        .doc(this._id)
        .set({'points': this._points});
    notifyListeners();
  }

  void buyCoupon(Coupon coupon) {
    _points = _points - coupon.points;
    _purchasedCoupons.add(
      PurchasedCoupon(
        coupon: coupon,
        datePurhcased: DateTime.now(),
        userId: this._id,
      ),
    );
    FirebaseFirestore.instance.collection('users').doc(this._id).set({
      'points': this._points,
      'purchased_coupons': this._purchasedCoupons,
    });
    notifyListeners();
  }

  void useCoupon(PurchasedCoupon coupon) {
    _usedCoupons.add(coupon.coupon);
    _purchasedCoupons.remove(coupon);
    FirebaseFirestore.instance.collection('users').doc(this._id).set({
      'used_coupons': this._usedCoupons,
      'purchased_coupons': this._purchasedCoupons,
    });
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

  List<Coupon> get myUsedCoupons {
    return _usedCoupons;
  }

  bool get isAuth {
    return _name != '';
  }

  List<PurchasedCoupon> get myAvailableCoupons {
    return _purchasedCoupons;
  }
}
