import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/Coupon.dart';
import '../models/PurchasedCoupon.dart';

class UserProvider with ChangeNotifier {
  String _id = FirebaseAuth.instance.currentUser.uid;
  String _name = '';
  int _points = 500;
  List<Coupon> _usedCoupons = [];
  List<PurchasedCoupon> _purchasedCoupons = [];
  StreamSubscription _subscription = null;

  UserProvider() {
    FirebaseAuth.instance.authStateChanges().listen((userSnapshot) {
      if (userSnapshot != null) {
        this._id = userSnapshot.uid;
        getUserData();
      }
    });
  }

  Future<void> getUserData() async {
    this._subscription = FirebaseFirestore.instance
        .collection('users')
        .doc(this._id)
        .snapshots()
        .listen((event) {
      final userData = event.data();
      this._name = userData['username'];
      this._points = userData['points'];
      // this._usedCoupons = userData['used_coupons'];
      // this._purchasedCoupons = userData['purchased_coupons'];
      notifyListeners();
    });
  }

  void logout() {
    this._id = null;
    this._subscription.cancel();
    FirebaseAuth.instance.signOut();
  }

  void addUserPoints(int points) {
    this._points = this._points + points;
    FirebaseFirestore.instance
        .collection('users')
        .doc(this._id)
        .update({'points': this._points});
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
    FirebaseFirestore.instance.collection('users').doc(this._id).update({
      'points': this._points,
      'purchased_coupons': this._purchasedCoupons,
    });
    notifyListeners();
  }

  void useCoupon(PurchasedCoupon coupon) {
    _usedCoupons.add(coupon.coupon);
    _purchasedCoupons.remove(coupon);
    FirebaseFirestore.instance.collection('users').doc(this._id).update({
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
