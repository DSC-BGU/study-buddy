import 'package:flutter/material.dart';
import '../../providers/purchased_coupon_provider.dart';
import 'dart:ui';

import '../../providers/Coupon_provider.dart';

class AvailableCoupon extends StatelessWidget {
  final String couponId;

  AvailableCoupon({
    @required this.couponId,
  });

  @override
  Widget build(BuildContext context) {
    PurchasedCouponProvider purchasedCouponProvider =
        PurchasedCouponProvider(this.couponId);
    String couponID = purchasedCouponProvider.couponId;
    CouponProvider couponProvider =
        CouponProvider(couponID); // Provider.of<CouponProvider>(context);
    // couponProvider.getCouponData(this.couponId);
    String couponImageUrl = couponProvider.imageUrl;
    String couponDescription = couponProvider.description;

    return LayoutBuilder(builder: (ctx, constraints) {
      return Container(
        margin: EdgeInsets.only(bottom: 8),
        height: constraints.maxWidth * 0.30,
        child: Stack(children: [
          Image.network(
            couponImageUrl,
            width: double.infinity,
            fit: BoxFit.fitWidth,
          ),
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            Container(
              width: double.infinity,
              color: Colors.black38,
              child: Text(
                couponDescription,
                style: TextStyle(color: Colors.white, fontSize: 26),
              ),
            ),
          ])
        ]),
      );
    });
  }
}
