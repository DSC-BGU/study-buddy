import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/PurchasedCoupon.dart';
import 'package:uuid/uuid.dart';
import '../models/Coupon.dart';

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
      List myUsedCoupons = userData['used_coupons'] as List;
      List myPurchasedCoupons = userData['purchased_coupons'] as List;

      this._name = userData['username'];
      this._points = userData['points'];
      this._usedCoupons = myUsedCoupons.map((c) => Coupon.fromJson(c)).toList();
      this._purchasedCoupons =
          myPurchasedCoupons.map((c) => PurchasedCoupon.fromJson(c)).toList();
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
        datePurhcased: new DateTime.now(),
        userId: this._id,
        purchasedCouponid: Uuid().v4(),
        used: true,
      ),
    );
    FirebaseFirestore.instance.collection('users').doc(this._id).update({
      'points': this._points,
      'purchased_coupons':
          this._purchasedCoupons.map((c) => c.toJson()).toList(),
    });
    notifyListeners();
  }

  void useCoupon(PurchasedCoupon coupon) {
    _usedCoupons.add(coupon.coupon);
    _purchasedCoupons.remove(coupon);
    FirebaseFirestore.instance.collection('users').doc(this._id).update({
      'used_coupons': this._usedCoupons.map((c) => c.toJson()).toList(),
      'purchased_coupons':
          this._purchasedCoupons.map((c) => c.toJson()).toList(),
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
