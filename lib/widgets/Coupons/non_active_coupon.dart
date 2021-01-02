import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NonActiveCoupon extends StatelessWidget {
  final String usedCouponId;
  String couponImageUrl;
  String couponDescription;

  NonActiveCoupon({
    @required this.usedCouponId,
    getCouponData(),
  });

  Future<void> getCouponData() async {
    FirebaseFirestore.instance
        .collection('coupons')
        .doc(usedCouponId)
        .snapshots()
        .listen((event) {
      final couponData = event.data();
      this.couponImageUrl = couponData['imageUrl'];
      this.couponDescription = couponData['description'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Container(
        margin: EdgeInsets.only(bottom: 8),
        height: constraints.maxWidth * 0.30,
        child: Stack(children: [
          Image.network(
            this.couponImageUrl,
            width: double.infinity,
            fit: BoxFit.fitWidth,
          ),
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            Container(
              width: double.infinity,
              color: Colors.black38,
              child: Text(
                this.couponDescription,
                style: TextStyle(color: Colors.white, fontSize: 26),
              ),
            ),
          ])
        ]),
      );
    });
  }
}
