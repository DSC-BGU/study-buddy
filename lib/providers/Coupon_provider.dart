import 'package:flutter/material.dart';
import '../models/Coupon.dart';

class CouponProvider with ChangeNotifier {
  List<Coupon> couponsList = [];

  List<Coupon> get coupons {
    return [...couponsList];
  }

  List<Coupon> storesCoupons(String storeID) {
    List<Coupon> storesCoupons =
        couponsList.where((element) => element.storeId == storeID).toList();
    return storesCoupons;
  }
}
