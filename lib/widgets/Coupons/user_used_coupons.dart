import 'package:flutter/material.dart';
import './active_coupon.dart';

class UserUsedCoupon extends StatelessWidget {
  final List<String> coupons;

  UserUsedCoupon(this.coupons);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return GestureDetector(
          onTap: () {
            return null;
          },
          child: ActiveCoupon(activeCouponId: coupons[index]),
        );
      },
      itemCount: coupons.length,
    );
  }
}
