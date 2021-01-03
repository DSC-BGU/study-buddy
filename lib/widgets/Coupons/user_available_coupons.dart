import 'package:flutter/material.dart';
import '../../Screens/Coupons/PopUpQR.dart';
import './available_coupon.dart';

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
                context: ctx, builder: (ctx) => PopUpQR(ctx, coupons[index]));
          },
          child: AvailableCoupon(couponId: coupons[index]),
        );
      },
      itemCount: coupons.length,
    );
  }
}
