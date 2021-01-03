import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CouponProvider with ChangeNotifier {
  final String _id; // = '';
  String _title = '';
  String _storeId = '';
  String _description = '';
  String _imageUrl = '';
  int _points = 0;

  CouponProvider(this._id) {
    getCouponData(this._id);
  }
  Future<void> getCouponData(String id) {
    FirebaseFirestore.instance
        .collection('coupons')
        .doc(id)
        .snapshots()
        .listen((event) {
      // this._id = id;
      final couponData = event.data();
      print('coupon data: ' + couponData.toString());
      this._title = couponData['title'];
      this._storeId = couponData['store'];
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
