import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_buddy/models/Coupon.dart';
import 'package:study_buddy/models/PurchasedCoupon.dart';

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
          myPurchasedCoupons.map((c) => c as String).toList();
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
    String newPurchasedCouponId;
    FirebaseFirestore.instance.collection('purchasedCoupons').add({
      'couponId': coupon.id,
      'userId': this._id,
      'datePurhcased': new DateTime.now(),
      'used': false,
    }).then((data) {
      newPurchasedCouponId = data.id;
    });
    this._points = this._points - coupon.points;
    this._purchasedCouponsId.add(newPurchasedCouponId);
    print(_purchasedCouponsId);
    FirebaseFirestore.instance.collection('users').doc(this._id).update({
      'points': this._points,
      'purchased_coupons': this._purchasedCouponsId.toList(),
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
    // FirebaseFirestore.instance.collection('users').doc(this._id).update({
    //   'purchased_coupons': this._purchasedCouponsID,
    // });
    notifyListeners();
  }

  List<String> getAvailableCoupons() {
    print('Hi!');
    List<String> output = [];
    _purchasedCouponsId.map((c) => FirebaseFirestore.instance
            .collection('purchasedCoupons')
            .doc(c)
            .snapshots()
            .listen((event) {
          final purchasedCouponData = event.data();
          print('data: ' + purchasedCouponData.toString());
          if (!purchasedCouponData['used']) {
            output.add(purchasedCouponData['couponId'].toString());
          }
        }));
    print(output);
    return output;
  }

  List<String> getUsedCoupons() {
    List<String> output = [];
    _purchasedCouponsId.map((c) => FirebaseFirestore.instance
            .collection('purchasedCoupons')
            .doc(c)
            .snapshots()
            .listen((event) {
          final purchasedCouponData = event.data();
          if (purchasedCouponData['used']) {
            output.add(purchasedCouponData['couponId']);
          }
        }));
    return output;
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
