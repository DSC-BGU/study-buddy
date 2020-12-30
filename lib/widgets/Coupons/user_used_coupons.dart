import 'package:flutter/material.dart';
import '../../models/Coupon.dart';
import './active_coupon.dart';

class UserUsedCoupon extends StatelessWidget {
  final List<Coupon> coupons;

  UserUsedCoupon(this.coupons);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return GestureDetector(
          onTap: () {
            return null;
          },
          child: ActiveCoupon(coupon: coupons[index]),
        );
      },
      itemCount: coupons.length,
    );
  }
}
