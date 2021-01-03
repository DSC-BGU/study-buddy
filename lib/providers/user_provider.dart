import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/Coupon.dart';

class UserProvider with ChangeNotifier {
  String _id = FirebaseAuth.instance.currentUser.uid;
  String _name = '';
  int _points = 500;
  List<String> _purchasedCouponsId = [];
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

      List myPurchasedCoupons = userData['purchased_coupons'] as List;
      this._name = userData['username'];
      this._points = userData['points'];
      this._purchasedCouponsId = //userData['purchased_coupons'].toList();
          myPurchasedCoupons.map((c) => json.encode(c)).toList();
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
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('purchasedCoupons').doc();
    docRef.set({
      'couponId': coupon.id,
      'userId': this._id,
      'datePurhcased': new DateTime.now(),
      'used': false,
    });
    this._points = this._points - coupon.points;
    this._purchasedCouponsId.add(docRef.id);
    FirebaseFirestore.instance.collection('users').doc(this._id).update({
      'points': this._points,
      'purchased_coupons':
          this._purchasedCouponsId, //.map((c) => json.decode(c)).toList(),
    });
    notifyListeners();
  }

  void useCoupon(String purchasedCouponId) {
    FirebaseFirestore.instance
        .collection('purchasedCoupons')
        .doc(purchasedCouponId)
        .update({
      'used': true,
    });
    // @TODO: update at user's list to!
    FirebaseFirestore.instance.collection('users').doc(this._id).update({
      'purchased_coupons':
          this._purchasedCouponsId, //.map((c) => json.decode(c)).toList(),
    });
    notifyListeners();
  }

  List<String> getAvailableCoupons() {
    List<String> output = [];
    CollectionReference coupons =
        FirebaseFirestore.instance.collection('purchasedCoupons');

    coupons
        .where('userId', isEqualTo: this._id)
        .where('used', isEqualTo: false)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        final data = doc.data();
        output.add(data['couponId']);
      });
    });
    print(output);
    return output;
  }

  List<String> getUsedCoupons() {
    List<String> output = [];
    CollectionReference coupons =
        FirebaseFirestore.instance.collection('purchasedCoupons');

    coupons
        .where('userId', isEqualTo: this._id)
        .where('used', isEqualTo: true)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        final data = doc.data();
        output.add(data['couponId']);
      });
    });
    print(output);
    return output;
    // List<String> output = [];
    // _purchasedCouponsId.map((c) => FirebaseFirestore.instance
    //         .collection('purchasedCoupons')
    //         .doc(c)
    //         .snapshots()
    //         .listen((event) {
    //       print('available data constructing');
    //       var purchasedCouponData = event.data();
    //       print(purchasedCouponData);
    //       if (purchasedCouponData['used']) {
    //         output.add(purchasedCouponData['couponId']);
    //       }
    //     }));
    // return output;
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

  bool get isAuth {
    return _name != '';
  }

  List<String> get myCouponsID {
    return _purchasedCouponsId;
  }
}
