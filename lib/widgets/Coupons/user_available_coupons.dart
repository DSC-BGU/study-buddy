import 'package:flutter/material.dart';
import './non_active_coupon.dart';
import '../../models/PurchasedCoupon.dart';
import '../../Screens/Coupons/PopUpQR.dart';

class UserAvailableCoupons extends StatelessWidget {
  final List<PurchasedCoupon> coupons;

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
          child: NonActiveCoupon(usedCoupon: coupons[index]),
        );
      },
      itemCount: coupons.length,
    );
  }
}
