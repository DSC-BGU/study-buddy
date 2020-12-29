import 'package:flutter/material.dart';
import './Coupon.dart';

class PurchasedCoupon {
  final String id;
  final String couponId;
  final String userId;
  final bool used;
  final int price;
  final DateTime datePurhcased;
  final Coupon coupon;

  const PurchasedCoupon(
      {@required this.id,
      @required this.couponId,
      @required this.userId,
      @required this.used,
      @required this.price,
      @required this.datePurhcased,
      @required this.coupon});
}
