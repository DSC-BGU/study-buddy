import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CouponProvider with ChangeNotifier {
  String _id = '';
  String _title = '';
  String _storeId = '';
  String _description = '';
  String _imageUrl = '';
  int _points = 0;

  Future<void> getCouponData(String id) async {
    FirebaseFirestore.instance
        .collection('coupons')
        .doc(id)
        .snapshots()
        .listen((event) {
      final couponData = event.data();
      this._title = couponData['title'];
      this._storeId = couponData['storeId'];
      this._description = couponData['description'];
      this._imageUrl = couponData['imageUrl'];
      this._points = couponData['points'];
      notifyListeners();
    });
  }

  String get id {
    return _id;
  }

  String get title {
    return _title;
  }

  String get storeId {
    return _storeId;
  }

  String get description {
    return _description;
  }

  String get imageUrl {
    return _imageUrl;
  }

  int get points {
    return _points;
  }

  // List<Coupon> couponsList = [];
  // List<Coupon> get coupons {
  //   return [...couponsList];
  // }
  // List<Coupon> storesCoupons(String storeID) {
  //   List<Coupon> storesCoupons =
  //       couponsList.where((element) => element.storeId == storeID).toList();
  //   return storesCoupons;
  // }
}
