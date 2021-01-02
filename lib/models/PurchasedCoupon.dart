import 'package:flutter/material.dart';
import './Coupon.dart';

class PurchasedCoupon {
  // final String couponId;
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

  factory PurchasedCoupon.fromJson(Map<String, dynamic> json) {
    return PurchasedCoupon(
      used: json['used'],
      userId: json['userId'],
      datePurhcased: json['datePurhcased'].toDate(),
      coupon: Coupon.fromJson(json['coupon']),
      purchasedCouponid: json['purchasedCouponid'],
    );
  }

  Map toJson() {
    Map _coupon = this.coupon.toJson();
    return {
      'userId': userId,
      'datePurhcased': datePurhcased,
      'coupon': _coupon,
      'used': used,
    };
  }
}
