import 'package:flutter/material.dart';
import './used_coupon.dart';

class UserUsedCoupons extends StatelessWidget {
  final List<String> coupons;
  UserUsedCoupons(this.coupons);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return GestureDetector(
          onTap: null,
          child: UsedCoupon(couponId: coupons[index]),
        );
      },
      itemCount: coupons.length,
    );
  }
}
