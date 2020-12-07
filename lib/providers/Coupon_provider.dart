import 'package:flutter/material.dart';
import 'package:study_buddy/models/Coupon.dart';
import 'package:study_buddy/dummy_data.dart';

class Coupon_provider with ChangeNotifier {
  List<Coupon> couponsList = DUMMY_COUPONS;

  List<Coupon> get coupons {
    return [...couponsList];
  }

  List<Coupon> storesCoupons(String storeID) {
    List<Coupon> storesCoupons =
        couponsList.where((element) => element.storeId == storeID).toList();
    return storesCoupons;
  }
}
