import 'package:flutter/material.dart';

class PurchasedCoupon {
  final String id;
  final String couponId;
  final String userId;
  final DateTime datePurhcased;
  bool used;

  PurchasedCoupon({
    @required this.id,
    @required this.couponId,
    @required this.userId,
    @required this.datePurhcased,
    this.used = false,
  });

  factory PurchasedCoupon.fromJson(
      Map<String, dynamic> json, String purchasedCouponId) {
    return PurchasedCoupon(
      id: purchasedCouponId,
      couponId: json['couponId'],
      userId: json['userId'],
      datePurhcased: json['datePurhcased'].toDate(),
      used: json['used'],
    );
  }

  Map toJson() {
    return {
      'id': id,
      'couponId': couponId,
      'userId': userId,
      'datePurhcased': datePurhcased,
      'used': used,
    };
  }
}
