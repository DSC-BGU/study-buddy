import 'package:flutter/material.dart';
import './non_active_coupon.dart';
import '../../Screens/Coupons/PopUpQR.dart';

class UserAvailableCoupons extends StatelessWidget {
  final List<String> coupons;

  UserAvailableCoupons(this.coupons);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return GestureDetector(
          onTap: () {
            showDialog(
                context: context,
                builder: (ctx) => PopUpQR(ctx, coupons[index]));
          },
          child: NonActiveCoupon(usedCouponId: coupons[index]),
        );
      },
      itemCount: coupons.length,
    );
  }
}
