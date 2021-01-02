import 'package:flutter/material.dart';
import './Coupon.dart';

class PurchasedCoupon {
  final String userId;
  final DateTime datePurhcased;
  final Coupon coupon;
  bool used;
  String purchasedCouponid;

  PurchasedCoupon({
    this.used = false,
    @required this.userId,
    @required this.datePurhcased,
    @required this.coupon,
    @required this.purchasedCouponid,
  });
}
