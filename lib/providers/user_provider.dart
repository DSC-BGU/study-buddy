import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/PurchasedCoupon.dart';
import '../models/Coupon.dart';

class UserProvider with ChangeNotifier {
  String _id = FirebaseAuth.instance.currentUser.uid;
  String _name = '';
  int _points = 500;
  List<String> _purchasedCouponsId = [];
  List<PurchasedCoupon> _purchasedCoupons = [];
  StreamSubscription _subscription = null;
  StreamSubscription _couponsSubscription = null;

  UserProvider() {
    FirebaseAuth.instance.authStateChanges().listen((userSnapshot) {
      if (userSnapshot != null) {
        this._id = userSnapshot.uid;
        getUserData();
        // cancel subscription first
        getPurchasedCoupons();
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

      List<dynamic> myPurchasedCoupons = userData['purchased_coupons'];
      this._name = userData['username'];
      this._points = userData['points'];
      this._purchasedCouponsId =
          myPurchasedCoupons.map((c) => c.toString()).toList();
      notifyListeners();
    });
  }

  void logout() {
    this._id = null;
    this._subscription.cancel();
    this._couponsSubscription.cancel();
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

// @TODO
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
    print(docRef.id);
    this._purchasedCouponsId.add(docRef.id);
    print(_purchasedCouponsId);
    FirebaseFirestore.instance.collection('users').doc(this._id).update({
      'points': this._points,
      'purchased_coupons': this._purchasedCouponsId,
    });
    getPurchasedCoupons();
    notifyListeners();
  }

// @TODO
  void useCoupon(String purchasedCouponId) {
    FirebaseFirestore.instance
        .collection('purchasedCoupons')
        .doc(purchasedCouponId)
        .update({
      'used': true,
    });
    notifyListeners();
  }

  void getPurchasedCoupons() {
    if (_couponsSubscription != null) {
      this._couponsSubscription.cancel();
    }
    if (_purchasedCouponsId.isNotEmpty) {
      _couponsSubscription = FirebaseFirestore.instance
          .collection('purchasedCoupons')
          .where(FieldPath.documentId, whereIn: _purchasedCouponsId)
          .snapshots()
          .listen((event) {
        print('purchasded: ' + _purchasedCouponsId.toString());
        event.docs.forEach((doc) {
          _purchasedCoupons.add(PurchasedCoupon.fromJson(doc.data()));
        });
        notifyListeners();
      });
    }
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
    return [..._purchasedCouponsId];
  }

  List<PurchasedCoupon> get myPurchasedCoupons {
    // print('coupons: ' + _purchasedCoupons.toString());
    return [..._purchasedCoupons];
  }
}

// // @TODO
//   List<Coupon> getUsedCoupons() {
//     List<String> output = [];
//     CollectionReference coupons =
//         FirebaseFirestore.instance.collection('purchasedCoupons');

//     coupons
//         .where('userId', isEqualTo: this._id)
//         .where('used', isEqualTo: true)
//         .get()
//         .then((querySnapshot) {
//       querySnapshot.docs.forEach((doc) {
//         final data = doc.data();
//         output.add(data['couponId']);
//       });
//     });
//     print(output);
//     return [];
//    // _coupons;
//     // List<String> output = [];
//     // _purchasedCouponsId.map((c) => FirebaseFirestore.instance
//     //         .collection('purchasedCoupons')
//     //         .doc(c)
//     //         .snapshots()
//     //         .listen((event) {
//     //       print('available data constructing');
//     //       var purchasedCouponData = event.data();
//     //       print(purchasedCouponData);
//     //       if (purchasedCouponData['used']) {
//     //         output.add(purchasedCouponData['couponId']);
//     //       }
//     //     }));
//     // return output;
//   }
