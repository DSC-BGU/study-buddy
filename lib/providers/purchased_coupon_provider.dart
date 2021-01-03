import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PurchasedCouponProvider with ChangeNotifier {
  String _id = '';
  String _couponId = '';
  String _userId = '';
  String _datePurhcased = '';
  bool _used = false;

  Future<void> getCouponData(String id) async {
    FirebaseFirestore.instance
        .collection('coupons')
        .doc(id)
        .snapshots()
        .listen((event) {
      final couponData = event.data();
      this._couponId = couponData['couponId'];
      this._userId = couponData['userId'];
      this._datePurhcased = couponData['datePurhcased'];
      this._used = couponData['used'];
      notifyListeners();
    });
  }

  String get id {
    return _id;
  }

  String get couponId {
    return _couponId;
  }

  String get userId {
    return _userId;
  }

  String get datePurhcased {
    return _datePurhcased;
  }

  bool get used {
    return _used;
  }

}
