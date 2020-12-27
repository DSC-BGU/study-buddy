import 'package:flutter/material.dart';
import 'package:study_buddy/dummy_data.dart';
import 'package:study_buddy/models/Coupon.dart';
import 'package:study_buddy/models/PurchasedCoupon.dart';

class User with ChangeNotifier {
  final String _id = null;
  final String _name = null;
  final List<PurchasedCoupon> _myCoupons = DUMMY_PURCHASED_COUPONS;

  String get id {
    String s = _id;
    return s;
  }

  List<Coupon> availableCoupons() {
    List<PurchasedCoupon> availableList =
        _myCoupons.where((element) => !element.used).toList();
    return availableList.map((e) => e.coupon).toList();
  }

  List<Coupon> usedCoupons() {
    List<PurchasedCoupon> purchasedList =
        _myCoupons.where((element) => element.used).toList();
    return purchasedList.map((e) => e.coupon).toList();
  }
}
