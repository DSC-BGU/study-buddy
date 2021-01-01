import 'package:flutter/material.dart';
import './Coupon.dart';

class PurchasedCoupon {
  final String userId;
  final DateTime datePurhcased;
  final Coupon coupon;
  // bool used;

  const PurchasedCoupon({
    @required this.userId,
    @required this.datePurhcased,
    @required this.coupon,
    // this.used = false,
  });
}
